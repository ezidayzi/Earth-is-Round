//
//  NicknameEditFeature.swift
//  SettingFeature
//
//  Created by Junho Lee on 2023/05/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import APIClient_ios
import ComposableArchitecture
import Dependencies
import Shared_ios

public struct NicknameEditFeature: ReducerProtocol {

    @Dependency(\.userAPI)
    var userAPI

    public init() {}
    
    public struct State: Equatable {
        @BindingState
        var nickname: String = KeychainClient.nickname ?? ""

        var helperText: String = ""
        var isValidNickname = false

        public init() {}
    }

    public enum Action: BindableAction {
        // View Actions
        case binding(BindingAction<State>)
        case naviBackButtonTapped
        case editButtonTapped

        // Internal Actions
        case _updateNickname(String)
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
            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))

            case .binding(\.$nickname):
                let isValid = state.nickname.isEnglish(range: (4...12))
                state.isValidNickname = isValid
                return .none

            case .editButtonTapped:
                return updateNickname(state.nickname)

            case let ._updateNickname(nickname):
                state.helperText = ""
                KeychainClient.nickname = nickname
                // 완료 토스트 메세지 
                return .send(.coordinator(.pop))

            case let ._updateHelperText(text):
                state.helperText = text
                state.isValidNickname = false
                return .none

            case .binding:
                return .none

            case .coordinator:
                return .none
            }

        }

        BindingReducer()
    }

    private func updateNickname(_ nickname: String) -> EffectTask<Action> {
        return .run { send in
            guard nickname != KeychainClient.nickname ?? "" else {
                return
            }
            let result = await userAPI.updateNickname(nickname.lowercased())
            switch result {
            case let .success(isSuccess):
                if isSuccess {
                    await send(._updateNickname(nickname.lowercased()))
                }
                // error처리
            case let .failure(error as ErrorCode):
                if error == .duplicateNickname {
                    await send(._updateHelperText("사용 중인 닉네임입니다!"))
                }
                if error == .invalidNickname {
                    await send(._updateHelperText("사용할 수 없는 닉네임입니다."))
                }
            case .failure:
                break
                // error처리
            }
        }
    }
}


