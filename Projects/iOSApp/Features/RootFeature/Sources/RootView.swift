import SwiftUI

import ComposableArchitecture
import TCACoordinators

import SplashFeature
import MainFeature
import AuthFeature

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
                    state: /RootFeature.State.auth,
                    action: RootFeature.Action.auth,
                    then: SignInView.init
                )
                CaseLet(
                    state: /RootFeature.State.main,
                    action: RootFeature.Action.main,
                    then: MainView.init
                )
            }
        }
    }
}
