import ComposableArchitecture
import Dependencies

import Shared_ios

public struct SignInFeature: ReducerProtocol {
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
    
    // TODO: Delegate를 사용하여 Navigating하기
    // embed 에러 발생함
    public enum Action: BindableAction, Equatable {
        // View Actions
        case binding(BindingAction<State>)
        case signInButtonTapped
        case naviBackButtonTapped
        
        // Internal Actions
        case _enableSignIn
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
                return .none
                
            case .naviBackButtonTapped:
                return .none
                
            case ._enableSignIn:
                let isEnabled = state.isValidPassword && state.isValidNickname
                state.signinIsEnabled = isEnabled
                return .none
            }
        }
        
        BindingReducer()
    }
}
