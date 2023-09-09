//
//  PasswordEditView.swift
//  SettingFeature
//
//  Created by Junho Lee on 2023/05/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import APIClient_ios
import ComposableArchitecture
import Dependencies
import Shared_ios

public struct PasswordEditFeature: ReducerProtocol {

    @Dependency(\.userAPI)
    var userAPI

    public init() {}
    
    public struct State: Equatable {
        @BindingState
        var password1: String = ""
        @BindingState
        var password2: String = ""

        var helperText: String = ""
        var editButtonEnabled: Bool = false

        public init() {}
    }

    public enum Action: BindableAction {
        // View Actions
        case binding(BindingAction<State>)
        case naviBackButtonTapped
        case editButtonTapped
        
        // Internal Actions
        case _enableEditPassword
        case _updateHelperText(String)

        // Coordinator
        case coordinator(CoordinatorAction)
        
        public enum CoordinatorAction {
            case pop
        }
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .binding(\.$password1):
                let isValid = state.password1.isEnglishAndNumber(range: (8...15))
                return isValid ? .send(._enableEditPassword) : .none

            case .binding(\.$password2):
                let isValid = state.password1.isEnglishAndNumber(range: (8...15))
                return isValid ? .send(._enableEditPassword) : .none

            case .binding:
                return .none

            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))

            case .editButtonTapped:
                return updatePassword(state.password1)

            case let ._updateHelperText(text):
                state.helperText = text
                return .none

            case ._enableEditPassword:
                if state.password1.isEmpty || state.password2.isEmpty {
                    return .none
                }
                let isValid = state.password1 == state.password2
                state.editButtonEnabled = isValid
                return isValid
                ? .send(._updateHelperText(""))
                : .send(._updateHelperText("비밀번호가 일치하지 않습니다."))

            case .coordinator:
                return .none

            }
        }
        BindingReducer()
    }

    private func updatePassword(_ password: String) -> EffectTask<Action> {
        return .run { send in
            let result = await userAPI.updatePassword(password.lowercased())
            switch result {
            case let .success(isSuccess):
                if isSuccess {
                    await send(.coordinator(.pop))
                }
                // error처리
            case let .failure(error as ErrorCode):
                if error == .invalidPassword {
                    await send(._updateHelperText("사용할 수 없는 비밀번호입니다."))
                }
               break
            case .failure:
                break
                // error처리
            }
        }
    }
}

