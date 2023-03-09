import ComposableArchitecture

import AuthFeature
import MainFeature
import SplashFeature

import SnowmanAlertFeature

public struct RootFeature: ReducerProtocol {
    public init() {}
    
    public enum State: Equatable {
        case splash(SplashFeature.State)
        case main(MainFeature.State)
        case auth(SignInFeature.State)
        
        case snowmanAlert(SnowmanAlertFeature.State)
    }
    
    // 예를 RootFeature가 아니라 RootScreen으로 생각하고, State는 다른 곳에서 관리

    public enum Action: Equatable {
        case splash(SplashFeature.Action)
        case main(MainFeature.Action)
        case auth(SignInFeature.Action)
        
        case snowmanAlert(SnowmanAlertFeature.Action)
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
        Scope(state: /State.snowmanAlert, action: /Action.snowmanAlert) {
            SnowmanAlertFeature()
        }
    }
}
