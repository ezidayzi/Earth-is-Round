//
//  SettingScreen.swift
//  SettingFeature
//
//  Created by Junho Lee on 2023/05/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import ComposableArchitecture

public struct SettingScreen: ReducerProtocol {
    public init() {}
    
    public enum State: Equatable {
        case setting(SettingFeature.State)
        case nicknameEdit(NicknameEditFeature.State)
        case passwordEdit(PasswordEditFeature.State)
    }

    public enum Action {
        case setting(SettingFeature.Action)
        case nicknameEdit(NicknameEditFeature.Action)
        case passwordEdit(PasswordEditFeature.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: /State.setting, action: /Action.setting) {
            SettingFeature()
        }
        Scope(state: /State.nicknameEdit, action: /Action.nicknameEdit) {
            NicknameEditFeature()
        }
        Scope(state: /State.passwordEdit, action: /Action.passwordEdit) {
            PasswordEditFeature()
        }
    }
}
