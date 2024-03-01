import SwiftUI
import DesignSystem_ios

import ComposableArchitecture

public struct ItemAlertView: View {
    
    let store: StoreOf<ItemAlertFeature>
    @ObservedObject var viewStore: ViewStoreOf<ItemAlertFeature>
    
    public init(store: StoreOf<ItemAlertFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        ZStack {
            Color.black
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)

            IfLet(viewStore.snowmanItemType) { snowmanItemType in
                VStack(spacing: 40) {
                    VStack() {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(ERColor.White)
                            .frame(width: 94, height: 30)
                            .overlay(
                                Text(viewStore.date)
                                    .foregroundColor(ERColor.Black50)
                            )
                            .padding()

                        Text("하루동안 굴러가며,")
                            .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 22).toSwiftUI)
                            .foregroundColor(ERColor.Black10)
                            .padding(.vertical, 8)

                        HStack(spacing: 0) {
                            Text("\(snowmanItemType.toKorean)")
                                .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 22).toSwiftUI)
                                .foregroundColor(ERColor.Black10)

                            Text("를 주웠어요")
                                .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 22).toSwiftUI)
                                .foregroundColor(ERColor.Black10)
                        }

                        pickUpItems

                        Text("\(viewStore.content ?? "")")
                            .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 16).toSwiftUI)
                            .foregroundColor(ERColor.Black50)
                            .padding(.vertical, 10)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(20)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 234 / 255, green: 208 / 255, blue: 255 / 255), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(24)
                    .padding(.horizontal, 30)

                    Button(action: {
                        viewStore.send(.updateCurrentIndex(index: 0))
                    }) {
                        Text("확인")
                            .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 17).toSwiftUI)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 62)
                            .foregroundColor(ERColor.Black10)
                            .background(ERColor.White)
                            .cornerRadius(40)
                    }
                }
            } elseContent: {
                EmptyView()
            }
        }
        .onAppear {
            viewStore.send(.onAppear)
            setupAppearance()
        }
    }

    private var pickUpItems: some View {
        TabView {
            let range = Array(0..<viewStore.snowmanItem.itemPoint.count)
            ForEach(range, id: \.self) { index in
                viewStore.snowmanItem.itemPoint[index].itemType.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.adjusted, height: 200.adjusted)
                    .onAppear {
                        viewStore.send(.updateCurrentIndex(index: index))
                    }
            }
        }
        .frame(height: 200.adjusted)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .padding()
    }

    private func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(ERColor.Main)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(ERColor.White)
    }
}
