//
//  AuthScreen.swift
//  AuthFeature
//
//  Created by Junho Lee on 2023/04/25.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import ComposableArchitecture

public struct AuthScreen: ReducerProtocol {
    public init() {}
    
    public enum State: Equatable {
        case auth(AuthFeature.State)
        case signUp(SignUpFeature.State)
        case signIn(SignInFeature.State)
    }

    public enum Action: Equatable {
        case auth(AuthFeature.Action)
        case signUp(SignUpFeature.Action)
        case signIn(SignInFeature.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: /State.auth, action: /Action.auth) {
            AuthFeature()
        }
        Scope(state: /State.signUp, action: /Action.signUp) {
            SignUpFeature()
        }
        Scope(state: /State.signIn, action: /Action.signIn) {
            SignInFeature()
        }
    }
}
