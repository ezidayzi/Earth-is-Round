//
//  NicknameEditView.swift
//  SettingFeature
//
//  Created by Junho Lee on 2023/05/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

public struct NicknameEditView: View {
    
    let store: StoreOf<NicknameEditFeature>
    @ObservedObject var viewStore: ViewStoreOf<NicknameEditFeature>
    
    public init(store: StoreOf<NicknameEditFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack(spacing: 0) {
            ERNavigationBar(title: "닉네임 변경", action: {
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


