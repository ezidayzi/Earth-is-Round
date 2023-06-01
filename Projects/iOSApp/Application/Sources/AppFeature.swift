import SwiftUI

import ComposableArchitecture
import TCACoordinators

import RootFeature

struct AppFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public var rootCoordinator = RootCoordinator.State()
        
        public init() {}
    }

    public enum Action {
        case rootCoordinator(RootCoordinator.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.rootCoordinator, action: /Action.rootCoordinator) {
            RootCoordinator()
        }
        
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
