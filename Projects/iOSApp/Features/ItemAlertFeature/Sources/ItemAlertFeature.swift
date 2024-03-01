import ComposableArchitecture
import LocalStorageClient_ios
import Dependencies
import Shared_ios

public struct ItemAlertFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        let snowmanItem: SnowmanItemInfo
        let date: String

        @BindingState
        var currentIndex = 0
        
        var snowmanItemType: SnowmanItemType?
        var content: String?

        public init(snowmanItems: [SnowmanItemInfo]) {
            self.snowmanItem = snowmanItems.first ?? SnowmanItemInfo(date: "", itemPoint: [])
            self.date = snowmanItems.first?.date ?? ""
        }
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        // View Actions
        case onAppear
        case updateCurrentIndex(index: Int)
        case okayButtonDidTap

        // Internal Actions


        // Coordinator
        case coordinator(CoordinatorAction)

        public enum CoordinatorAction {
            case pop
        }
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.snowmanItemType = state.snowmanItem.itemPoint.first?.itemType

                switch state.snowmanItem.itemPoint.count {
                case 1:
                    state.content = "내일은 더 많이 주워보세요!"
                case 2:
                    state.content = "조금만 더 주워볼까요?"
                case 3:
                    state.content = "지구가 깨끗해지고 있어요!"
                case 4:
                    state.content = "지구 한 바퀴까지 함께 해요!"
                default:
                    state.content = "잘 하고 있어요!"
                }
                return .none

            case .updateCurrentIndex(let index):
                state.currentIndex = index
                return .none

            case .okayButtonDidTap:
                return .send(.coordinator(.pop))

            case .binding:
                return .none
                
            case .coordinator:
                return .none

            }
        }
        BindingReducer()
    }
}
