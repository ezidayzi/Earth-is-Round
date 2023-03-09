import ComposableArchitecture
import SwiftUI
import TCACoordinators

public struct RootCoordinator: ReducerProtocol {
    public init() { }
    
    public struct State: Equatable, IndexedRouterState {
        public init() {
            self.routes = [.root(.splash(.init()), embedInNavigationView: true)]
        }
        
        public var routes: [Route<RootFeature.State>]
    }
    
    public enum Action: Equatable, IndexedRouterAction {
        case routeAction(Int, action: RootFeature.Action)
        case updateRoutes([Route<RootFeature.State>])
    }
    
    public var body: some ReducerProtocol<State, Action> {
        return Reduce<State, Action> { state, action in
            switch action {
            case let .routeAction(_, .splash(splashAction)):
                switch splashAction {
                case .splashAnimationFinished:
                    return .routeWithDelaysIfUnsupported(state.routes) { route in
                        route.append(.root(.auth(.init())))
                        
                    }
                }
                
            case let .routeAction(_, .auth(authAction)):
                switch authAction {
                case .signInButtonTapped:
                    state.routes.push(.main(.init()))
                }
                
            case let .routeAction(_, .main(mainAction)):
                switch mainAction {
                case .delegate(.checkTodayPopup):
                    state.routes.presentSheet(.snowmanAlert(.init()))
                default:
                    return .none
                }
                
            default:
                break
            }
            
            return .none
        }.forEachRoute {
            RootFeature()
        }
    }
}
