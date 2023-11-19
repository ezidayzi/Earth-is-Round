import APIClient_ios
import Foundation
import ComposableArchitecture
import Dependencies
import Shared_ios

public struct SnowmanAlertFeature: ReducerProtocol {
    public init() {}

    public enum ViewType {
        case popUp
        case push
    }

    public struct State: Equatable {
        let startDate: String
        let viewType: ViewType

        var date: String?
        var title: String?
        var speechBubbleText: String?
        var steps: [Int]?
        var snowmanType: SnowmanType?
        var items: [SnowmanItemType]?
        var isLoading: Bool = false

        public init(startDate: String, viewType: ViewType) {
            self.startDate = startDate
            self.viewType = viewType
        }
    }

    public enum Action {
        // View Actions
        case naviBackButtonTapped
        case onAppear

        // Internal Actions
        case _fetchDate(endDate: String)
        case _fetchSteps([Int])
        case _fetchSnowman(snowmanType: SnowmanType, items: [SnowmanItemType])

        // Coordinator
        case coordinator(CoordinatorAction)

        public enum CoordinatorAction {
            case pop
        }
    }

    @Dependency(\.recordAPI)
    var recordAPI

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                return fetchSnowmanDetail(startDate: state.startDate)

            case let ._fetchSteps(steps):
                state.steps = steps
                return .none

            case let ._fetchSnowman(snowmanType, items):
                state.snowmanType = snowmanType
                state.items = items
                state.speechBubbleText = getSpeechBubbleText(type: snowmanType)
                state.isLoading = false
                return .none

            case let ._fetchDate(endDate):
                state.title = getMonthAndWeek(from: state.startDate)
                state.date = combineDateRange(startDate: state.startDate, endDate: endDate)
                return .none

            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))

            case .coordinator:
                return .none
            }
        }
    }

    private func fetchSnowmanDetail(startDate: String) -> EffectTask<Action> {
        return .run { send in
            let result = await recordAPI.getDetail(startDate)
            switch result {
            case let .success(response):
                let snowmanType = SnowmanType(
                    headSize: response.snowman.headSize,
                    bodySize: response.snowman.bodySize
                )
                let snowmanItem = response.snowman.usedItems
                await send(._fetchDate(endDate: response.snowman.endDate))
                await send(._fetchSteps(response.steps))
                await send(._fetchSnowman(snowmanType: snowmanType, items: snowmanItem))
            case .failure:
                break
            }
        }
    }

    private func getMonthAndWeek(from dateString: String) -> String? {
        if let date = dateString.toDate(dateFormat: .yearMonthDay) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month, .weekOfMonth], from: date)

            if let month = components.month, let weekOfMonth = components.weekOfMonth {
                return "\(month)월 \(weekOfMonth)주차"
            }
        }
        return nil
    }

    private func combineDateRange(startDate: String, endDate: String) -> String? {
        if let startDate = startDate.toDate(dateFormat: .yearMonthDay),
            let endDate = endDate.toDate(dateFormat: .yearMonthDay) {

            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.month, .day], from: startDate)
            let endComponents = calendar.dateComponents([.month, .day], from: endDate)

            if let startMonth = startComponents.month,
                let startDay = startComponents.day,
                let endMonth = endComponents.month,
                let endDay = endComponents.day {
                return "\(startMonth).\(startDay)-\(endMonth).\(endDay)"
            }
        }

        return nil
    }

    func getSpeechBubbleText(type: SnowmanType) -> String {
        let responses: [String]

        switch type {
        case .largeHeadSmallBody:
            responses = [
                "뭔가 잘 못 됨~^^*",
                "저… 어떻게 서 있는 거죠?",
                "나한테 왜 이러세요 ㅠ",
                "이건 비극이야.."
            ]
        case .largeHeadLargeBody:
            responses = [
                "멋지게 태어나서 행복해요~",
                "만들어줘서 고마워요^^",
                "너무도 완벽한 비율!",
                "오늘도 지구는 둥글군요^-^",
                "당신은 지구 지킴이~",
                "금손이구만요~!"
            ]
        case .smallHeadLargeBody:
            responses = [
                "비율이 좀 이상한데..",
                "머리 좀만 더 크게 만들어주지^^",
                "불안불안 하더니만 ㅠㅠ",
                "다음에는 발란스 좀 맞춰주쇼"
            ]
        case .smallHeadSmallBody:
            responses = [
                "너무 모자른거 아니에요?",
                "곧 있으면 다 녹겠어",
                "이걸 우짤쓰까..",
                "이게 무슨 일인가 지금~!"
            ]
        }

        let randomIndex = Int(arc4random_uniform(UInt32(responses.count)))
        return responses[randomIndex]
    }

}
