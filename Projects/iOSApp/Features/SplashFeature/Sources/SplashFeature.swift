import ComposableArchitecture
import Dependencies
import Shared_ios

public struct SplashFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        // View Actions
        case splashAnimationFinished

        // Coordinator
        case coordinator(CoordinatorAction)

        public enum CoordinatorAction {
            case toAuth
            case toMain
        }
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .splashAnimationFinished:
                if KeychainClient.token == nil || KeychainClient.nickname == nil {
                    return .send(.coordinator(.toAuth))
                }
                return .send(.coordinator(.toMain))
            case .coordinator:
                return .none
            }
        }
    }
}
