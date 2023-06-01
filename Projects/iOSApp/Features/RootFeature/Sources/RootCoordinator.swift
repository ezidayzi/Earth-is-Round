import SwiftUI

import ComposableArchitecture
import TCACoordinators

public struct RootCoordinator: ReducerProtocol {
    public init() { }
    
    public struct State: Equatable, IndexedRouterState {
        public init() {
            self.routes = [.root(.splash(.init()), embedInNavigationView: true)]
        }
        
        public var routes: [Route<RootScreen.State>]
    }
    
    public enum Action: IndexedRouterAction {
        case routeAction(Int, action: RootScreen.Action)
        case updateRoutes([Route<RootScreen.State>])
    }
    
    public var body: some ReducerProtocol<State, Action> {
        return Reduce<State, Action> { state, action in
            switch action {
            case let .routeAction(_, .splash(splashAction)):
                switch splashAction {
                case .splashAnimationFinished:
                    state.routes = [.root(.auth(.init()))]
                }
                
            case let .routeAction(_, .auth(authAction)):
                switch authAction {
                case let .routeAction(_, authScreenAction):
                    switch authScreenAction {
                    case .signIn(.signInButtonTapped),
                        .signUp(.signUpButtonTapped):
                        state.routes = [.root(
                            .main(.init(
                                currentWeekDay: 0,
                                pastSteps: []
                            )),
                            embedInNavigationView: true
                        )]
                        
                    default:
                        return .none
                    }
                    
                default:
                    return .none
                }
                
            case let .routeAction(_, .main(mainAction)):
                switch mainAction {
                case .delegate(.checkTodayPopup):
                    state.routes.presentSheet(.snowmanAlert(.init()))
                    
                case .delegate(.pushSettingView):
                    state.routes.push(.setting(.init()))
                    
                default:
                    return .none
                }
                
            default:
                break
            }
            
            return .none
        }.forEachRoute {
            RootScreen()
        }
    }
}
