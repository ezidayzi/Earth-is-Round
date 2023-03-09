import SwiftUI

import ComposableArchitecture
import TCACoordinators

import SplashFeature
import AuthFeature
import MainFeature
import SettingFeature
import ArchiveFeature
import SnowmanAlertFeature
import ItemAlertFeature

public struct RootView: View {
    
    let store: StoreOf<RootCoordinator>
    @ObservedObject var viewStore: ViewStoreOf<RootCoordinator>
    
    public init(store: StoreOf<RootCoordinator>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        TCARouter(store) { store in
            SwitchStore(store) {
                CaseLet(
                    state: /RootFeature.State.splash,
                    action: RootFeature.Action.splash,
                    then: SplashView.init
                )
                CaseLet(
                    state: /RootFeature.State.main,
                    action: RootFeature.Action.main,
                    then: MainView.init
                )
                CaseLet(
                    state: /RootFeature.State.auth,
                    action: RootFeature.Action.auth,
                    then: SignInView.init
                )
                CaseLet(
                    state: /RootFeature.State.setting,
                    action: RootFeature.Action.setting,
                    then: SettingView.init
                )
                CaseLet(
                    state: /RootFeature.State.archive,
                    action: RootFeature.Action.archive,
                    then: ArchiveView.init
                )
                CaseLet(
                    state: /RootFeature.State.snowmanAlert,
                    action: RootFeature.Action.snowmanAlert,
                    then: SnowmanAlertView.init
                )
                CaseLet(
                    state: /RootFeature.State.itemAlert,
                    action: RootFeature.Action.itemAlert,
                    then: ItemAlertView.init
                )
            }
        }
    }
}
