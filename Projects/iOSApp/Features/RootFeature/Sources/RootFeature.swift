import ComposableArchitecture

import AuthFeature
import MainFeature
import SplashFeature
import SettingFeature
import ArchiveFeature
import SnowmanAlertFeature
import ItemAlertFeature

public struct RootFeature: ReducerProtocol {
    public init() {}
    
    public enum State: Equatable {
        case splash(SplashFeature.State)
        case auth(SignInFeature.State)
        case main(MainFeature.State)
        case setting(SettingFeature.State)
        case archive(ArchiveFeature.State)
        case snowmanAlert(SnowmanAlertFeature.State)
        case itemAlert(ItemAlertFeature.State)
    }
    
    // 예를 RootFeature가 아니라 RootScreen으로 생각하고, State는 다른 곳에서 관리

    public enum Action: Equatable {
        case splash(SplashFeature.Action)
        case auth(SignInFeature.Action)
        case main(MainFeature.Action)
        case setting(SettingFeature.Action)
        case archive(ArchiveFeature.Action)
        case snowmanAlert(SnowmanAlertFeature.Action)
        case itemAlert(ItemAlertFeature.Action)
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
        Scope(state: /State.setting, action: /Action.setting) {
            SettingFeature()
        }
        Scope(state: /State.archive, action: /Action.archive) {
            ArchiveFeature()
        }
        Scope(state: /State.snowmanAlert, action: /Action.snowmanAlert) {
            SnowmanAlertFeature()
        }
        Scope(state: /State.itemAlert, action: /Action.itemAlert) {
            ItemAlertFeature()
        }
    }
}
