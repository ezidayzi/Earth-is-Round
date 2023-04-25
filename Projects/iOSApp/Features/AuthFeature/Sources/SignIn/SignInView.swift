import SwiftUI

import ComposableArchitecture

import Shared_ios
import DesignSystem_ios

public struct SignInView: View {
    
    private enum Metric {
        static let topPadding = (132 - 74).adjustedH
        static let textFieldSpacing = 49.adjustedH
        static let buttonTopSpacing = 355.adjustedH
        static let buttonBottomPadding = (62 - 34).adjustedH
    }
    
    let store: StoreOf<SignInFeature>
    @ObservedObject var viewStore: ViewStoreOf<SignInFeature>
    
    public init(store: StoreOf<SignInFeature>) {
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
                    viewStore.send(.signUpButtonTapped)
                }
                .erButton(
                    labelColor: viewStore.signinIsEnabled
                    ? ERColor.White : ERColor.Black50,
                    backgroundColor: viewStore.signinIsEnabled
                    ? ERColor.Main : ERColor.Black90
                )
                .disabled(viewStore.signinIsEnabled)
                
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
