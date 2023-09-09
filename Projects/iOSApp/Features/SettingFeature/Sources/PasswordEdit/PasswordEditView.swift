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
            .padding(.bottom, 54.adjustedH)
            VStack(alignment: .leading) {
                ERTextField(
                    text: viewStore.binding(\.$password1),
                    isValid: false,
                    maxLength: 15,
                    placeholder: "영문, 숫자 8 ~ 15자로 입력해 주세요."
                )
                Spacer()
                    .frame(height: 16.adjustedH)
                ERTextField(
                    text: viewStore.binding(\.$password2),
                    isValid: false,
                    maxLength: 15,
                    placeholder: "영문, 숫자 8 ~ 15자로 입력해 주세요."
                )
                Text(viewStore.helperText)
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 13).toSwiftUI)
                    .foregroundColor(ERColor.Alert)
                    .frame(height: 32.adjustedH)
                    .padding(.leading, 12)
                Spacer()
                    .frame(height: 30.adjustedH)
                Button("저장") {
                    viewStore.send(.editButtonTapped, animation: Animation.easeIn(duration: 0.2))
                }
                .erButton(
                    labelColor: viewStore.editButtonEnabled
                    ? ERColor.White : ERColor.Black50,
                    backgroundColor: viewStore.editButtonEnabled
                    ? ERColor.Main : ERColor.Black90
                )
                .disabled(!viewStore.editButtonEnabled)
                Spacer()
            }.horizontalPadding()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

