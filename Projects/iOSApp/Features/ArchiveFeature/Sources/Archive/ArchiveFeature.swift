import APIClient_ios
import ComposableArchitecture
import Dependencies
import Domain_ios
import Foundation
import Shared_ios


public struct ArchiveFeature: ReducerProtocol {

    public init() {}
    
    public struct State: Equatable {
        var archiveList: [MonthlyArchive]?
        var isLoading: Bool = false
        public init() {}
    }

    public enum Action {
        // View Actions
        case naviBackButtonTapped
        case onAppear
        case snowmanCardDidTapped(startDate: String)

        // Internal Actions
        case _fetchArchiveList([MonthlyArchive])

        // Coordinator
        case coordinator(CoordinatorAction)

        public enum CoordinatorAction {
            case pop
            case toDetail(_ startDate: String)
        }
    }


    @Dependency(\.recordAPI)
    var recordAPI

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))

            case .onAppear:
                state.isLoading = true
                return fetchArchiveList()

            case let ._fetchArchiveList(list):
                state.archiveList = list
                state.isLoading = false
                return .none

            case .snowmanCardDidTapped(let startDate):
                return .send(.coordinator(.toDetail(startDate)))

            case .coordinator:
                return .none

            }
        }
    }

    private func fetchArchiveList() -> EffectTask<Action> {
        .run { send in
            let result = await recordAPI.getList(Date().toString(withFormat: .yearMonthDay))
            switch result {
            case let .success(response):
                let records = response.snowmen
                var monthlyArchives: [MonthlyArchive] = []

                let snowmenByMonth = Dictionary(grouping: records) { snowman in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM"
                    return dateFormatter.string(from: snowman.startDate.toDate(dateFormat: .yearMonthDay) ?? Date())
                }

                for (month, snowmenInMonth) in snowmenByMonth {
                    let weeklyArchives = snowmenInMonth.map { snowman in
                        WeeklyArchive(
                            uuid: UUID(),
                            week: snowman.startDate.toDate(
                                dateFormat: .yearMonthDay
                            )?.weekNumberStartingOnMonday ?? 0,
                            snowmanType: SnowmanType(headSize: snowman.headSize, bodySize: snowman.bodySize),
                            snowmanItemTypes: snowman.usedItems,
                            startDate: snowman.startDate
                        )
                    }

                    monthlyArchives.append(MonthlyArchive(
                        uuid: UUID(),
                        month: month.toDate(dateFormat: .yearMonth)?.month ?? 0,
                        weeklyArchive: weeklyArchives
                    ))
                }
                monthlyArchives.sort()
                
                for index in monthlyArchives.indices {
                    monthlyArchives[index].weeklyArchive.sort()
                }
                await send(._fetchArchiveList(monthlyArchives))
                
            case .failure:
                await send(._fetchArchiveList([]))
            }
        }
    }
}
