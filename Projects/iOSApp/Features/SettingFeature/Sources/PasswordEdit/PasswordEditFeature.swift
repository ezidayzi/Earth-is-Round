//
//  PasswordEditView.swift
//  SettingFeature
//
//  Created by Junho Lee on 2023/05/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import ComposableArchitecture
import Dependencies

public struct PasswordEditFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {
        // View Actions
        case naviBackButtonTapped
        
        // Internal Actions
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .naviBackButtonTapped:
                return .none
            }
        }
    }
}

