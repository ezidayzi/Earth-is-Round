import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

public struct SignInView: View {
    
    let store: StoreOf<SignInFeature>
    @ObservedObject var viewStore: ViewStoreOf<SignInFeature>
    
    public init(store: StoreOf<SignInFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            Spacer(minLength: 301 - 44)
            
            DesignSystemIosAsset.Assets.splashTitle.swiftUIImage
            
            Spacer()
            
            Button("회원가입") {
                
            }
            .buttonStyle(ERButton(labelColor: DesignSystemIosAsset.Assets.white.swiftUIColor))
            .background(Color.white)
            .dynamicCornerRadius(ERColor.Black50)
            .frame(maxWidth: .infinity) // Fill the screen width
            
            Spacer(minLength: 20)
            
            Button {
                
            } label: {
                Text("로그인")
                    .frame(maxWidth: .infinity)
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 18).toSwiftUI)
                    .foregroundColor(DesignSystemIosAsset.Assets.black10.swiftUIColor)
                    .padding(.vertical, 17)a
                    .background(Color.white)
            }
            
            .dynamicCornerRadius(ERColor.Black50)

            Spacer(minLength: 62)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            Color(.white)
        )
        .padding(.horizontal) // Add left and right margin
    }
}
