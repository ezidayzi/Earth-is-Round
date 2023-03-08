import ComposableArchitecture

import AuthFeature
import MainFeature
import SplashFeature

public struct RootFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        var splash: SplashFeature.State?
        var main: MainFeature.State?
        var auth: SignInFeature.State?
        
        public init() { self.splash = SplashFeature.State() }
    }

    public enum Action: Equatable {
        case splash(SplashFeature.Action)
        case main(MainFeature.Action)
        case auth(SignInFeature.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .splash(splashAction) :
                switch splashAction {
                case .splashAnimationFinished:
                    state.splash = nil
                    state.auth = SignInFeature.State()
                }
            case let .auth(authAction):
                switch authAction {
                case .signInButtonTapped:
                    state.auth = nil
                    state.main = MainFeature.State()
                }
            }
            return .none
        }
        .ifLet(\.splash, action: /Action.splash) {
            SplashFeature()
        }
        .ifLet(\.main, action: /Action.main) {
            MainFeature()
        }
        .ifLet(\.auth, action: /Action.auth) {
            SignInFeature()
        }
    }
}
