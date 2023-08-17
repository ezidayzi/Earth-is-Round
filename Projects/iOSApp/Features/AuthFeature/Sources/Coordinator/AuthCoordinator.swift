//
//  AuthCoordinator.swift
//  AuthFeature
//
//  Created by Junho Lee on 2023/04/25.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

public struct AuthCoordinator: ReducerProtocol {
    public init() { }

    public struct State: Equatable, IndexedRouterState {
        public init() {
            self.routes = [.root(.auth(.init()), embedInNavigationView: true)]
        }

        public var routes: [Route<AuthScreen.State>]
    }

    public enum Action: IndexedRouterAction {
        case routeAction(Int, action: AuthScreen.Action)
        case updateRoutes([Route<AuthScreen.State>])
    }

    public var body: some ReducerProtocol<State, Action> {
        return Reduce<State, Action> { state, action in
            switch action {
            case let .routeAction(_, .auth(authAction)):
                switch authAction {
                case .coordinator(.signIn):
                    state.routes.push(.signIn(.init()))
                case .coordinator(.signUp):
                    state.routes.push(.signUp(.init()))
                }

            case let .routeAction(_, .signIn(signInAction)):
                switch signInAction {
                case .coordinator(.pop):
                    state.routes.pop()

                default:
                    return .none
                }

            case let .routeAction(_, .signUp(signUpAction)):
                switch signUpAction {
                case .coordinator(.pop):
                    state.routes.pop()

                default:
                    return .none
                }

            default:
                break
            }

            return .none
        }.forEachRoute {
            AuthScreen()
        }
    }
}

