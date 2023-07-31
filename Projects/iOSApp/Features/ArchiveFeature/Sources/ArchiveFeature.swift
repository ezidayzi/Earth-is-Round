import ComposableArchitecture
import Dependencies

import Foundation
import Domain_ios

public struct ArchiveFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        var archiveList: [MonthlyArchive]?
        var isLoading: Bool = false
        public init() {}
    }

    public enum Action: Equatable {
        case naviBackButtonTapped
        case coordinator(CoordinatorAction)
        case onAppear

        case _fetchArchiveList([MonthlyArchive])

        public enum CoordinatorAction {
            case pop
            case detail
        }
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))
            case .coordinator:
                return .none
            case .onAppear:
                state.isLoading = true
                return fetchArchiveList()
            case let ._fetchArchiveList(list):
                state.archiveList = list
                return .none
            }
        }
    }

    private func fetchArchiveList() -> EffectTask<Action> {
        .run { send in
            // 서버 통신
            let list = [
                MonthlyArchive(
                    uuid: UUID(),
                    month: 12,
                    weeklyArchive: [
                        WeeklyArchive(
                            uuid: UUID(),
                            week: 1,
                            snowmanType: .largeHeadSmallBody,
                            snowmanItemTypes: [.airPodMax2, .boots, .carrot, .sunglass]
                        ),
                        WeeklyArchive(
                            uuid: UUID(),
                            week: 2,
                            snowmanType: .largeHeadSmallBody,
                            snowmanItemTypes: [.airPodMax2, .boots, .carrot, .sunglass]
                        ),
                        WeeklyArchive(
                            uuid: UUID(),
                            week: 3,
                            snowmanType: .largeHeadSmallBody,
                            snowmanItemTypes: [.airPodMax2, .boots, .carrot, .sunglass]
                        )
                    ]
                ),
                MonthlyArchive(
                    uuid: UUID(),
                    month: 1,
                    weeklyArchive: [
                        WeeklyArchive(
                            uuid: UUID(),
                            week: 1,
                            snowmanType: .largeHeadSmallBody,
                            snowmanItemTypes: [.airPodMax2, .boots, .carrot, .sunglass]
                        ),
                        WeeklyArchive(
                            uuid: UUID(),
                            week: 2,
                            snowmanType: .largeHeadSmallBody,
                            snowmanItemTypes: [.airPodMax2, .boots, .carrot, .sunglass]
                        ),
                        WeeklyArchive(
                            uuid: UUID(),
                            week: 3,
                            snowmanType: .largeHeadSmallBody,
                            snowmanItemTypes: [.airPodMax2, .boots, .carrot, .sunglass]
                        )
                    ]
                ),
                MonthlyArchive(
                    uuid: UUID(),
                    month: 2,
                    weeklyArchive: [
                        WeeklyArchive(
                            uuid: UUID(),
                            week: 1,
                            snowmanType: .largeHeadSmallBody,
                            snowmanItemTypes: [.airPodMax2, .boots, .carrot, .sunglass]
                        ),
                        WeeklyArchive(
                            uuid: UUID(),
                            week: 2,
                            snowmanType: .largeHeadSmallBody,
                            snowmanItemTypes: [.airPodMax2, .boots, .carrot, .sunglass]
                        ),
                        WeeklyArchive(
                            uuid: UUID(),
                            week: 3,
                            snowmanType: .largeHeadSmallBody,
                            snowmanItemTypes: [.airPodMax2, .boots, .carrot, .sunglass]
                        )
                    ]
                )
            ]
            await send(._fetchArchiveList(list))
        }
    }
}
