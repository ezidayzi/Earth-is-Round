import ComposableArchitecture
import Dependencies
import Shared_ios

public struct SettingFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        // View Actions
        case naviBackButtonTapped
        case nicknameEditTapped
        case passwordEditTapped
        
        // Internal Actions
        
        // Coordinator
        case coordinator(CoordinatorAction)
        
        public enum CoordinatorAction {
            case pop
            case pushNicknameEdit
            case pushPasswordEdit
        }
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .nicknameEditTapped:
                return .send(.coordinator(.pushNicknameEdit))
                
            case .passwordEditTapped:
                return .send(.coordinator(.pushPasswordEdit))
                
            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))
                
            case .coordinator:
                return .none
            }
        }
    }
}
