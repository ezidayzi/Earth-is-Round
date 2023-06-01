import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

public struct SettingView: View {
    
    let store: StoreOf<SettingFeature>
    @ObservedObject var viewStore: ViewStoreOf<SettingFeature>
    
    public init(store: StoreOf<SettingFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ERNavigationBar(title: "설정", action: {
                viewStore.send(.naviBackButtonTapped)
            })
            .padding(.bottom, 44.5.adjustedH)
            
            VStack(spacing: 1.adjustedH) {
                
                settingItem(text: "닉네임 변경") {
                    viewStore.send(.nicknameEditTapped)
                }
                
                settingItem(text: "비밀번호 변경")  {
                    viewStore.send(.passwordEditTapped)
                }
                .padding(.bottom, 20.adjustedH)
                
                settingItem(text: "개인정보 처리방침")
                
                settingItem(text: "서비스 이용약관")
                
                settingItem(text: "서비스 문의 및 의견")
                    .padding(.bottom, 20.adjustedH)
                
                settingItem(text: "눈사람 굴리는 사람들")
                    .padding(.bottom, 20.adjustedH)
                
                settingItem(text: "로그아웃")
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Text("탈퇴하기")
                            .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 15).toSwiftUI)
                            .foregroundColor(ERColor.Black50)
                            .padding(10)
                            .frame(alignment: .trailing)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 24.adjusted)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    private func settingItem(
        text: String,
        action: (() -> Void)? = nil
    ) -> some View {
        Text(text)
            .padding(21.adjusted)
            .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 15).toSwiftUI)
            .foregroundColor(ERColor.Black10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(ERColor.Black90)
            .cornerRadius(8)
            .onTapGesture {
                action?()
            }
    }
}
