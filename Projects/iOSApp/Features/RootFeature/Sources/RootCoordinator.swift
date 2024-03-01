import SwiftUI
import SnowmanAlertFeature
import ArchiveFeature

import ComposableArchitecture
import TCACoordinators

import SplashFeature
import AuthFeature
import MainFeature
import SettingFeature

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
                handleSplashAction(splashAction, state: &state)
                
            case let .routeAction(_, .auth(authCoordinatorAction)):
                handleAuthCoordinatorAction(authCoordinatorAction, state: &state)
                
            case let .routeAction(_, .main(mainAction)):
                handleMainAction(mainAction, state: &state)

            case let .routeAction(_, .archive(archiveAction)):
                handleMainAction(archiveAction, state: &state)
                
            case let .routeAction(_, .setting(settingCoordinator)):
                handleSettingAction(settingCoordinator, state: &state)

            case let .routeAction(_, action: .snowmanAlert(snowmanAlertFeature)):
                handleSnowmanAlertAction(snowmanAlertFeature, state: &state)
                
            default:
                break
            }
            
            return .none
            
        }.forEachRoute {
            RootScreen()
        }
    }
}

// MARK: - Splash

extension RootCoordinator {
    private func handleSplashAction(
        _ action: SplashFeature.Action,
        state: inout State
    ) {
        switch action {
        case .coordinator(.toMain):
            state.routes = [.root(
                .main(.init(
                    currentWeekDay: 0,
                    pastSteps: []
                )),
                embedInNavigationView: true
            )]
        case .coordinator(.toAuth):
            state.routes = [.root(.auth(.init()), embedInNavigationView: true)]
        default:
            break
        }
    }
}

// MARK: - AuthCoordinator

extension RootCoordinator {
    private func handleAuthCoordinatorAction(
        _ action: AuthCoordinator.Action,
        state: inout State
    ) {
        switch action {
        case let .routeAction(_, authAction):
            // AuthAction
            switch authAction {
            case .signIn(.coordinator(.toMain)),
                    .signUp(.coordinator(.toMain)):
                state.routes = [.root(
                    .main(.init(
                        currentWeekDay: 0,
                        pastSteps: []
                    )),
                    embedInNavigationView: true
                )]

            default:
                break
            }

        default:
            break
        }
    }
}

// MARK: - Main

extension RootCoordinator {
    private func handleMainAction(
        _ action: MainFeature.Action,
        state: inout State
    ) {
        switch action {
        case .coordinator(.toSnowmanAlert(let startDate)):
            state.routes.presentSheet(.snowmanAlert(.init(startDate: startDate, viewType: .popUp)))

        case .coordinator(.toItemAlert(let snowmanItems)):
            state.routes.presentCover(.itemAlert(.init(snowmanItems: snowmanItems)))

        case .coordinator(.toSetting):
            state.routes.push(.setting(.init()))

        case .coordinator(.toArchive):
            state.routes.push(.archive(.init()))
            
        default:
            break
        }
    }
}

// MARK: - Archive
extension RootCoordinator {
    private func handleMainAction(
        _ action: ArchiveFeature.Action,
        state: inout State
    ) {
        switch action {
        case .coordinator(.pop):
            state.routes.pop()

        case .coordinator(.toDetail(let startDate)):
            state.routes.push(.snowmanAlert(.init(startDate: startDate, viewType: .push)))

        default:
            break
        }
    }
}

// MARK: - Archive
extension RootCoordinator {
    private func handleSnowmanAlertAction(
        _ action: SnowmanAlertFeature.Action,
        state: inout State
    ) {
        switch action {
        case .coordinator(.pop):
            state.routes.pop()

        default:
            break
        }
    }
}

// MARK: - Setting Coordinator

extension RootCoordinator {
    private func handleSettingAction(
        _ action: SettingCoordinator.Action,
        state: inout State
    ) {
        switch action {
            // Setting View
        case let .routeAction(_, action: .setting(settingAction)):
            switch settingAction {
            case .coordinator(.toSplash):
                state.routes = [.root(.splash(.init()), embedInNavigationView: true)]
            case .coordinator(.pop):
                state.routes.pop()
            default:
                break
            }
            
        default:
            break
        }
    }
}
