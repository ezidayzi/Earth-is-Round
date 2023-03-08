import SwiftUI

import ComposableArchitecture

import RootFeature

struct AppFeature: ReducerProtocol {
    struct State: Equatable {
        var rootCoordinator = RootCoordinator.State()
    }

    enum Action: Equatable {
        case rootCoordinator(RootCoordinator.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
                
            default:
                return .none
            }
        }
        
        Scope(state: \.rootCoordinator, action: /Action.rootCoordinator) {
            RootCoordinator()
        }
    }
}
