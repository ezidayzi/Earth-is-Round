import ComposableArchitecture
import Dependencies

public struct ArchiveFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        
    }

    public enum Action: Equatable {
        
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}
