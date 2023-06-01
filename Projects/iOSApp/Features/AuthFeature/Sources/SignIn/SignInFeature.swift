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
    
    public enum Action: BindableAction, Equatable {
        // View Actions
        case binding(BindingAction<State>)
        case signInButtonTapped
        case naviBackButtonTapped
        
        // Internal Actions
        case _enableSignIn
        
        // Coordinator
        case coordinator(CoordinatorAction)
        
        public enum CoordinatorAction {
            case pop
            // Note(230602)
            // SingIn 및 SingUp 로직 Delegate로 분리하기
            case tmpSignIn
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
                return .send(.coordinator(.tmpSignIn))
                
            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))
                
            case ._enableSignIn:
                let isEnabled = state.isValidPassword && state.isValidNickname
                state.signinIsEnabled = isEnabled
                return .none
                
            case .coordinator:
                return .none
            }
        }
        
        BindingReducer()
    }
}
