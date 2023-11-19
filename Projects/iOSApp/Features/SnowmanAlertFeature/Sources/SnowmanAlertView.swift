import SwiftUI

import ComposableArchitecture

import DesignSystem_ios
import Shared_ios

public struct SnowmanAlertView: View {
    
    let store: StoreOf<SnowmanAlertFeature>
    @ObservedObject var viewStore: ViewStoreOf<SnowmanAlertFeature>
    
    public init(store: StoreOf<SnowmanAlertFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        VStack {
            if viewStore.viewType == .push {
                ERNavigationBar(
                    title: I18N.Archive.mySnowman,
                    backgroundColor: ERColor.BackgroundBlue
                ) {
                    viewStore.send(.naviBackButtonTapped)
                }
            }
            ScrollView {
                VStack {
                    if viewStore.isLoading {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else {
                        Spacer()
                            .frame(height: 96.adjustedH)

                        if viewStore.viewType == .popUp {
                            titleText
                                .padding(.bottom, 80.adjustedH)
                        }

                        if let speechText = viewStore.speechBubbleText {
                            ERSpeechBalloon(text: {
                                Text(speechText)
                                    .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 16).toSwiftUI)
                            }, color: ERColor.White)
                            .padding(.horizontal, 56.adjusted)
                            .frame(height: 108.adjustedH)
                        }


                        if let snowmanItem = viewStore.items, let snowmanType = viewStore.snowmanType {
                            SnowmanView(
                                snowmanItemTypes: snowmanItem,
                                snowmanType: snowmanType
                            )
                            .frame(width: 250)
                            .frame(height: 250 * 4/3)
                        }


                        Spacer()
                            .frame(height: 50)

                        bottomContent
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(ERColor.White)
                            )
                            .padding(.horizontal, 16.adjusted)

                        
                        Spacer()
                            .frame(height: 40.adjustedH)

                        if viewStore.viewType == .popUp {
                            Button("확인") {
                                viewStore.send(.naviBackButtonTapped)
                            }
                            .erButton(
                                labelColor: ERColor.White,
                                backgroundColor: ERColor.Black10
                            )
                            .padding(.horizontal, 24.adjusted)
                        }
                    }
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            DesignSystemIosAsset.Assets.backgroundBlue.swiftUIColor
        )
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            viewStore.send(.onAppear)
        }
    }

    private var titleText: some View {
        VStack {
            if let title = viewStore.title {
                Text(title)
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.bold.font(size: 22).toSwiftUI)
                    .foregroundColor(DesignSystemIosAsset.Assets.black10.swiftUIColor)
                    .padding(.bottom, 4.adjustedH)
            }
            
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

            if let steps = viewStore.steps,
                steps.count > 0,
                let standard = steps.reduce(0, +)/steps.count {
                WeeklyWalkView(steps: steps, standard: standard)
                    .frame(height: 60)
            }
            
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

                if let date = viewStore.date {
                    Text("\(date)")
                        .foregroundColor(ERColor.Black70)
                        .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 14).toSwiftUI)
                        .padding(5)
                        .dynamicCornerRadius(ERColor.Black70)
                }
            }

            if let totalStep = viewStore.steps?.reduce(0, +) {
                Text(totalStep.decimal)
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.bold.font(size: 28).toSwiftUI)
            }
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
            ForEach(viewStore.items ?? [], id: \.self) { item in
                item.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 71.adjusted, height: 88.adjusted)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(ERColor.BackgroundBlue, lineWidth: 1)
                    )
            }
        }
    }
}
