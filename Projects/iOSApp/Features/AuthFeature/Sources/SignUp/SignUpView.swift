//
//  SignUpView.swift
//  AuthFeature
//
//  Created by Junho Lee on 2023/04/25.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

public struct SignUpView: View {
    
    private enum Metric {
        static let topPadding = (132 - 74).adjustedH
        static let textFieldSpacing = 49.adjustedH
        static let buttonTopSpacing = 355.adjustedH
        static let buttonBottomPadding = (62 - 34).adjustedH
    }
    
    let store: StoreOf<SignUpFeature>
    @ObservedObject var viewStore: ViewStoreOf<SignUpFeature>
    @FocusState var isFocused: Bool
    
    public init(store: StoreOf<SignUpFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        // Note(230426)
        // Fixed Frame에서 keyboard avoidance를 회피하기 위해 ScrollView 사용
        ScrollView {
            VStack {
                
                Spacer()
                    .frame(height: Metric.topPadding)
                
                titleTextField(
                    title: "닉네임",
                    placeHolder: "영문 4 ~ 12자로 입력해 주세요.",
                    text: viewStore.binding(\.$nickname),
                    isValid: viewStore.isValidNickname,
                    maxLength: 12
                )
                
                Spacer()
                    .frame(height: Metric.textFieldSpacing)
                
                titleSecureField(
                    title: "비밀번호",
                    placeHolder: "영문, 숫자 8 ~ 15자로 입력해 주세요.",
                    text: viewStore.binding(\.$password),
                    isValid: viewStore.isValidPassword,
                    maxLength: 15
                )
                
                Spacer()
                    .frame(height: Metric.buttonTopSpacing)
                
                Button("회원가입") {
                    viewStore.send(.signUpButtonTapped, animation: Animation.easeIn(duration: 0.2))
                }
                .erButton(
                    labelColor: viewStore.signupIsEnabled
                    ? ERColor.White : ERColor.Black50,
                    backgroundColor: viewStore.signupIsEnabled
                    ? ERColor.Main : ERColor.Black90
                )
                .disabled(!viewStore.signupIsEnabled)
                
                Spacer()
                    .frame(height: Metric.buttonBottomPadding)
            }
            .horizontalPadding()
        }
        .scrollDisabled(true)
        .onTapHideKeyboard()
        .ignoresSafeArea(.keyboard)
    }
}
