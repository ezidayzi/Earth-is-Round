//
//  AuthFeature.swift
//  AuthFeature
//
//  Created by Junho Lee on 2023/04/25.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import ComposableArchitecture
import Dependencies

public struct AuthFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {
        case signInButtonTapped
        case signUpButtonTapped
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}

