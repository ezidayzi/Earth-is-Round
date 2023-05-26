//
//  SettingCoordinatorView.swift
//  SettingFeature
//
//  Created by Junho Lee on 2023/05/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

public struct SettingCoordinatorView: View {
    
    let store: StoreOf<SettingCoordinator>
    @ObservedObject var viewStore: ViewStoreOf<SettingCoordinator>
    
    public init(store: StoreOf<SettingCoordinator>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        TCARouter(store) { store in
            SwitchStore(store) {
                CaseLet(
                    state: /SettingScreen.State.setting,
                    action: SettingScreen.Action.setting,
                    then: SettingView.init
                )
                CaseLet(
                    state: /SettingScreen.State.passwordEdit,
                    action: SettingScreen.Action.passwordEdit,
                    then: PasswordEditView.init
                )
                CaseLet(
                    state: /SettingScreen.State.nicknameEdit,
                    action: SettingScreen.Action.nicknameEdit,
                    then: NicknameEditView.init
                )
            }
        }
    }
}
