//
//  AuthCoordinatorView.swift
//  AuthFeature
//
//  Created by Junho Lee on 2023/04/25.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

public struct AuthCoordinatorView: View {
    
    let store: StoreOf<AuthCoordinator>
    @ObservedObject var viewStore: ViewStoreOf<AuthCoordinator>
    
    public init(store: StoreOf<AuthCoordinator>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        TCARouter(store) { store in
            SwitchStore(store) {
                CaseLet(
                    /AuthScreen.State.auth,
                    action: AuthScreen.Action.auth,
                    then: AuthView.init
                )
                CaseLet(
                    /AuthScreen.State.signIn,
                    action: AuthScreen.Action.signIn,
                    then: SignInView.init
                )
                CaseLet(
                    /AuthScreen.State.signUp,
                    action: AuthScreen.Action.signUp,
                    then: SignUpView.init
                )
            }
        }
    }
}
