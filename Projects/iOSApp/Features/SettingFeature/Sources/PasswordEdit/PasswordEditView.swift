//
//  PasswordEditView.swift
//  SettingFeature
//
//  Created by Junho Lee on 2023/05/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

public struct PasswordEditView: View {
    
    let store: StoreOf<PasswordEditFeature>
    @ObservedObject var viewStore: ViewStoreOf<PasswordEditFeature>
    
    public init(store: StoreOf<PasswordEditFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack(spacing: 0) {
            ERNavigationBar(title: "비밀번호 변경", action: {
                viewStore.send(.naviBackButtonTapped)
            })
            .padding(.bottom, 44.5.adjustedH)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .toolbar(.hidden, for: .navigationBar)
    }
}

