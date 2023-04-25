import ComposableArchitecture
import Dependencies

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
        case binding(BindingAction<State>)
        case signUpButtonTapped
        case _enableSignIn
    }

    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.$nickname):
                let isValidLength = (6...12) ~= state.nickname.count
                state.isValidNickname = isValidLength
                return .send(._enableSignIn)
                
            case .binding(\.$password):
                let isValidLength = (8...15) ~= state.password.count
                state.isValidPassword = isValidLength
                return .send(._enableSignIn)
                
            case .binding:
                return .none
                
            case ._enableSignIn:
                let isEnabled = state.isValidPassword && state.isValidNickname
                state.signinIsEnabled = isEnabled
                return .none
                                
            case .signUpButtonTapped:
                return .none
            }
        }
    }
}
