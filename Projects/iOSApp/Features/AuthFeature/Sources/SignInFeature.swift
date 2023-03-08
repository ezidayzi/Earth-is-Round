import ComposableArchitecture
import Dependencies

public struct SignInFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {
        case signInButtonTapped
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}
