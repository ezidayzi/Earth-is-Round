import ComposableArchitecture
import Dependencies

public struct MainFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case checkTodayPopup
        }
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.delegate(.checkTodayPopup))
                
            case .delegate:
                return .none
            }
        }
    }
}
