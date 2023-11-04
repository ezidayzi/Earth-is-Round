import APIClient_ios
import ComposableArchitecture
import Dependencies

import Shared_ios

public struct SignInFeature: ReducerProtocol {

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
        var signinIsEnabled = false
        
        public init() {}
    }
    
    public enum Action: BindableAction {
        // View Actions
        case binding(BindingAction<State>)
        case signInButtonTapped
        case naviBackButtonTapped
        
        // Internal Actions
        case _enableSignIn
        case _successSignIn
        case _failureSignIn
        
        // Coordinator
        case coordinator(CoordinatorAction)
        
        public enum CoordinatorAction {
            case pop
            case toMain
        }
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .binding(\.$nickname):
                let isValid = state.nickname.isEnglish(range: (4...12))
                state.isValidNickname = isValid
                return .send(._enableSignIn)
                
            case .binding(\.$password):
                let isValid = state.password.isEnglishAndNumber(range: (8...15))
                state.isValidPassword = isValid
                return .send(._enableSignIn)
                
            case .binding:
                return .none
                
            case .signInButtonTapped:
                return requestLogin(
                    nickname: state.nickname,
                    password: state.password
                )

            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))
                
            case ._enableSignIn:
                let isEnabled = state.isValidPassword && state.isValidNickname
                state.signinIsEnabled = isEnabled
                return .none

            case ._successSignIn:
                return .send(.coordinator(.toMain))

            case ._failureSignIn:
                return .none
                
            case .coordinator:
                return .none
            }
        }
        
        BindingReducer()
    }

    private func requestLogin(nickname: String, password: String) -> EffectTask<Action> {
        .run { send in
            let result = await userAPI.login(nickname, password)
            switch result {
            case .success(let loginResponse):
                print("Login Response: \(loginResponse)")
                KeychainClient.token = loginResponse.token
                KeychainClient.nickname = loginResponse.nickname
                await send(._successSignIn)
            case .failure(let failure as ErrorCode):
                print("Login Failure: \(failure.description)")
                await send(._failureSignIn)
            case .failure:
                await send(._failureSignIn)
            }
        }
    }
}
