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

    public enum Action: BindableAction, Equatable {
        // View Actions
        case binding(BindingAction<State>)
        case signUpButtonTapped
        
        // Internal Actions
        case _enableSignUp
    }

    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        
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
                
            case ._enableSignUp:
                let isEnabled = state.isValidPassword && state.isValidNickname
                state.signupIsEnabled = isEnabled
                return .none
                                
            case .signUpButtonTapped:
                return .none
            }
        }
    }
}
