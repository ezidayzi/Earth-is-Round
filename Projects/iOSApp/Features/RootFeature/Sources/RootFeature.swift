import ComposableArchitecture

import AuthFeature
import MainFeature
import SplashFeature

public struct RootFeature: ReducerProtocol {
    public init() {}
    
    public enum State: Equatable {
        case splash(SplashFeature.State)
        case main(MainFeature.State)
        case auth(SignInFeature.State)
    }

    public enum Action: Equatable {
        case splash(SplashFeature.Action)
        case main(MainFeature.Action)
        case auth(SignInFeature.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: /State.splash, action: /Action.splash) {
            SplashFeature()
        }
        Scope(state: /State.auth, action: /Action.auth) {
            SignInFeature()
        }
        Scope(state: /State.main, action: /Action.main) {
            MainFeature()
        }
    }
}
