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
        ScrollView {
            VStack {
                Spacer()
                    .frame(height: 96.adjustedH)
                
                titleText
                    .padding(.bottom, 80.adjustedH)
                
                ERSpeechBalloon(text: {
                    Text("머리 조금만 더 크게 만들어주지..")
                        .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 16).toSwiftUI)
                }, color: ERColor.White)
                .padding(.horizontal, 56.adjusted)
                .frame(height: 108.adjustedH)
                
                Spacer()
                    .frame(height: 300.adjustedH)
                
                Button("확인") {
                    
                }
                .erButton(
                    labelColor: ERColor.White,
                    backgroundColor: ERColor.Black10
                )
                .padding(.horizontal, 24.adjusted)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            DesignSystemIosAsset.Assets.backgroundBlue.swiftUIColor
        )
    }
    
    private var titleText: some View {
        VStack {
            Text("12월 1주차")
                .font(DesignSystemIosFontFamily.AritaDotumOTF.bold.font(size: 22).toSwiftUI)
                .foregroundColor(DesignSystemIosAsset.Assets.black10.swiftUIColor)
                .padding(.bottom, 4.adjustedH)
            
            Text("눈사람이 정산되었어요.")
                .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 22).toSwiftUI)
                .foregroundColor(DesignSystemIosAsset.Assets.black10.swiftUIColor)
        }
    }
}
