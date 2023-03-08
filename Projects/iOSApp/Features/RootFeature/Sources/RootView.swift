import SwiftUI

import ComposableArchitecture

import SplashFeature
import MainFeature
import AuthFeature

public struct RootView: View {
    
    let store: StoreOf<RootFeature>
    @ObservedObject var viewStore: ViewStoreOf<RootFeature>
    
    public init(store: StoreOf<RootFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        IfLetStore(
            store.scope(
                state: \.splash,
                action: RootFeature.Action.splash
            )
        ) { store in
            SplashView(store: store)
        }
        IfLetStore(
            store.scope(
                state: \.auth,
                action: RootFeature.Action.auth
            )
        ) { store in
            SignInView(store: store)
        }
        IfLetStore(
            store.scope(
                state: \.main,
                action: RootFeature.Action.main
            )
        ) { store in
            MainView(store: store)
        }
    }
}
