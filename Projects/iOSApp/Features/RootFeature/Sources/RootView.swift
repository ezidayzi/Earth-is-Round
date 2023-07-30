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

public struct RootCoordinatorView: View {
    
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
                    /RootScreen.State.splash,
                    action: RootScreen.Action.splash,
                    then: SplashView.init
                )
                CaseLet(
                    /RootScreen.State.main,
                    action: RootScreen.Action.main,
                    then: MainView.init
                )
                CaseLet(
                    /RootScreen.State.auth,
                    action: RootScreen.Action.auth,
                    then: AuthCoordinatorView.init
                )
                CaseLet(
                    /RootScreen.State.setting,
                    action: RootScreen.Action.setting,
                    then: SettingCoordinatorView.init
                )
                CaseLet(
                    /RootScreen.State.archive,
                    action: RootScreen.Action.archive,
                    then: ArchiveView.init
                )
                CaseLet(
                    /RootScreen.State.snowmanAlert,
                    action: RootScreen.Action.snowmanAlert,
                    then: SnowmanAlertView.init
                )
                CaseLet(
                    /RootScreen.State.itemAlert,
                    action: RootScreen.Action.itemAlert,
                    then: ItemAlertView.init
                )
            }
        }
    }
}
