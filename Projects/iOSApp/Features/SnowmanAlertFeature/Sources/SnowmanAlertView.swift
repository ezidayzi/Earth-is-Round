import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

// TODO: - Store 구현
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
                
                // TODO: - 눈사람 추가 구현
                Spacer()
                    .frame(height: 300.adjustedH)
                
                bottomContent
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(ERColor.White)
                    )
                    .padding(.horizontal, 16.adjusted)
                
                Spacer()
                    .frame(height: 40.adjustedH)
                
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
    
    private var bottomContent: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 24.adjustedH)
            
            walksSection
                .padding(.horizontal, 17.adjusted)
            
            Spacer()
                .frame(height: 38.adjustedH + 24.adjustedH)
            
            WeeklyWalkView(steps: [100, 50, 30, 20, 40, 70, 30], standard: 60)
                .frame(height: 60)
            
            Divider()
                .foregroundColor(ERColor.Black10)
                .padding(.bottom, 25.adjustedH)
            
            pickUpSection
        }
    }
    
    private var walksSection: some View {
        Group {
            HStack {
                Text("전체 걸음수")
                    .foregroundColor(ERColor.Black10)
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 15).toSwiftUI)
                
                Spacer()
                
                Text("12.01-12.07")
                    .foregroundColor(ERColor.Black70)
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 14).toSwiftUI)
                    .padding(5)
                    .dynamicCornerRadius(ERColor.Black70)
            }
            
            Text(1234567.decimal)
                .font(DesignSystemIosFontFamily.AritaDotumOTF.bold.font(size: 28).toSwiftUI)
        }
    }
    
    private var pickUpSection: some View {
        Group {
            Text("주운 아이템들")
                .foregroundColor(ERColor.Black10)
                .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 15).toSwiftUI)
                .padding(.horizontal, 17.adjusted)
            
            pickUpItems
                .padding(.horizontal, 17.adjusted)
                .padding(.bottom, 36.adjustedH)
        }
    }
    
    private var pickUpItems: some View {
        LazyVGrid(columns: (1...4).map { _ in return GridItem(.flexible()) }, spacing: 9.adjusted) {
            ForEach((1...10).map { "Item \($0)" }, id: \.self) { item in
                DesignSystemIosAsset.Assets.icnSnowman.swiftUIImage
                    .scaledToFill()
                    .frame(width: 71.adjusted, height: 88.adjusted)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(ERColor.BackgroundBlue, lineWidth: 1)
                    )
            }
        }
    }
}
