//
//  SignUpFeature.swift
//  AuthFeature
//
//  Created by Junho Lee on 2023/04/25.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import ComposableArchitecture
import Dependencies

import Shared_ios

public struct SignUpFeature: ReducerProtocol {

    @Dependency(\.userAPI)
    var userAPI

    public init() {}
    
    public struct State: Equatable {
        @BindingState
        var nickname = ""
        @BindingState
        var password = ""
        
        var isValidNickname = false
        var isValidPassword = false
        var signupIsEnabled = false
        
        public init() {}
    }

    public enum Action: BindableAction {
        // View Actions
        case binding(BindingAction<State>)
        case signUpButtonTapped
        case naviBackButtonTapped
        
        // Internal Actions
        case _enableSignUp
        case _successSignUp
        case _failureSignUp
        
        // Coordinator
        case coordinator(CoordinatorAction)
        
        public enum CoordinatorAction {
            case pop
            case tmpSignUp
        }
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .binding(\.$nickname):
                let isValid = state.nickname.isEnglish(range: (4...12))
                state.isValidNickname = isValid
                return .send(._enableSignUp)
                
            case .binding(\.$password):
                let isValid = state.password.isEnglishAndNumber(range: (8...15))
                state.isValidPassword = isValid
                return .send(._enableSignUp)
                
            case .binding:
                return .none
                
            case .signUpButtonTapped:
                return requestSignUp(
                    nickname: state.nickname,
                    password: state.password
                )
                
            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))
                
            case ._enableSignUp:
                let isEnabled = state.isValidPassword && state.isValidNickname
                state.signupIsEnabled = isEnabled
                return .none

            case ._successSignUp:
                return .send(.coordinator(.tmpSignUp))

            case ._failureSignUp:
                return .none

            case .coordinator:
                return .none
            }
        }
        
        BindingReducer()
    }

}

extension SignUpFeature {
    private func requestSignUp(nickname: String, password: String) -> EffectTask<Action> {
        .run { send in
            do {
                let loginResponse = try await userAPI.signUp(nickname, password)
                print("Login Response: \(loginResponse)")
                await send(._successSignUp)
            } catch {
                print(error)
                await send(._failureSignUp)
            }
        }
    }
}
