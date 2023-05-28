import ComposableArchitecture
import Dependencies

public struct SettingFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {
        // View Actions
        case nicknameEditTapped
        case passwordEditTapped
        
        // Internal Actions
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .nicknameEditTapped:
                return .none
                
            case .passwordEditTapped:
                return .none
            }
        }
    }
}
