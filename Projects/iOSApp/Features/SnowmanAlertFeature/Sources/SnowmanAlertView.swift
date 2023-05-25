import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

public struct SnowmanAlertView: View {
    
    let store: StoreOf<SnowmanAlertFeature>
    @ObservedObject var viewStore: ViewStoreOf<SnowmanAlertFeature>
    
    public init(store: StoreOf<SnowmanAlertFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            ERSpeechBalloon(text: {
                Text("머리 조금만 더 크게 만들어주지..")
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 16).toSwiftUI)
            }, color: DesignSystemIosAsset.Assets.white.swiftUIColor)
            .padding(.horizontal, 56.adjusted)
            .frame(height: 108.adjustedH)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            DesignSystemIosAsset.Assets.backgroundBlue.swiftUIColor
        )
    }
}
