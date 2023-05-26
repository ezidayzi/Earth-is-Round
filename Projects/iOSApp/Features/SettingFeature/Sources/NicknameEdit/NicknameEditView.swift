//
//  NicknameEditView.swift
//  SettingFeature
//
//  Created by Junho Lee on 2023/05/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct NicknameEditView: View {
    
    let store: StoreOf<NicknameEditFeature>
    @ObservedObject var viewStore: ViewStoreOf<NicknameEditFeature>
    
    public init(store: StoreOf<NicknameEditFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        EmptyView()
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background(Color.yellow)
    }
}


