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
            .padding(.bottom, 54.adjustedH)
            VStack {
                ERTextField(
                    text: viewStore.binding(\.$nickname),
                    isValid: viewStore.isValidNickname,
                    maxLength: 12,
                    placeholder: "영문 4 ~ 12자로 입력해 주세요."
                )
                Text(viewStore.helperText)
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 13).toSwiftUI)
                    .foregroundColor(ERColor.Alert)
                    .frame(height: 32.adjustedH)
                    .padding(.leading)
                Spacer()
                    .frame(height: 30.adjustedH)
                Button("저장") {
                    viewStore.send(.editButtonTapped, animation: Animation.easeIn(duration: 0.2))
                }
                .erButton(
                    labelColor: viewStore.isValidNickname
                    ? ERColor.White : ERColor.Black50,
                    backgroundColor: viewStore.isValidNickname
                    ? ERColor.Main : ERColor.Black90
                )
                .disabled(!viewStore.isValidNickname)
                Spacer()
            }.horizontalPadding()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}


