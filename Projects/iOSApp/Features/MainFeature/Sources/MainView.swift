import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

public struct MainView: View {
    
    let store: StoreOf<MainFeature>
    @ObservedObject var viewStore: ViewStoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        ZStack {
            VStack {
                mainContent
            }
            
            if viewStore.isLoading {
                loadingIndicator
            }
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
    
    private var mainContent: some View {
        VStack() {
            customNavigationBar
            
            VStack(alignment: .leading) {
                stepsContent
                    .padding(.top, 44)
                    .padding(.leading, 22)
                
                snowmanButton
                    .padding(.leading, 22)
            }
            
            Spacer()
            
            /// - Note (230730) @Duno
            /// Lottie File의 영역이 부정확하게 잡혀 있음. 디자인 요청 필요.
            ERSnowBall(animationSpeed: viewStore.binding(\.$currentSpeed))
                .frame(height: 300)
            
            achievementRateView
                .padding(.top, 37)
                .padding(.bottom, 33)
        }
        .ignoresSafeArea(edges: .top)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
    
    private var customNavigationBar: some View {
        HStack {
            weekDayButton
            
            Spacer()
            
            Button(action: {
                viewStore.send(.settingButtonTapped)
            }) {
                DesignSystemIosAsset.Assets.icnSetting.swiftUIImage
            }
        }
        .padding(.horizontal, 22)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
    }
    
    private var weekDayButton: some View {
        HStack(spacing: 20) {
            Button(action: {
                viewStore.send(.prevButtonTapped)
            }) {
                DesignSystemIosAsset.Assets.icnLeftArrow.swiftUIImage
                    .renderingMode(.template)
                    .foregroundColor(viewStore.prevButtonEnabled ? .blue : .gray)
                    .frame(width: 35, height: 35)
            }
            .disabled(!viewStore.prevButtonEnabled)
            
            Text(viewStore.weekDayString)
                .offset(x: -5)
            
            Button(action: {
                viewStore.send(.nextButtonTapped)
            }) {
                DesignSystemIosAsset.Assets.icnRightArrow.swiftUIImage
                    .renderingMode(.template)
                    .foregroundColor(viewStore.nextButtonEnabled ? .blue : .gray)
            }
            .disabled(!viewStore.nextButtonEnabled)
        }
    }
    
    private var stepsContent: some View {
        VStack {
            HStack {
                stepsText
                
                Spacer()
            }
            .padding(.leading)
        }
    }
    
    private var stepsText: some View {
        IfLet(viewStore.displayedSteps) { steps in
            VStack(alignment: .leading) {
                Text("오늘은 \(steps)보")
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.bold.font(size: 30).toSwiftUI)
                    .foregroundColor(DesignSystemIosAsset.Assets.black10.swiftUIColor)
                Text("굴러가는 중")
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 30).toSwiftUI)
                    .foregroundColor(DesignSystemIosAsset.Assets.black10.swiftUIColor)
            }
        } elseContent: {
            Text("걸음 수 접근 권한이 없습니다.")
        }
    }
    
    private var snowmanButton: some View {
        HStack {
            DesignSystemIosAsset.Assets.icnSnowman.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            Text("내 눈사람")
                .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 14).toSwiftUI)
                .foregroundColor(DesignSystemIosAsset.Assets.black20.swiftUIColor)
        }
        .padding()
        .background(Capsule().fill(DesignSystemIosAsset.Assets.black90.swiftUIColor))
        .dynamicCornerRadius(DesignSystemIosAsset.Assets.black70.swiftUIColor)
        .padding(.leading)
        .onTapGesture {
            viewStore.send(.mySnowmanButtonTapped)
        }
    }
    
    private var achievementRateView: some View {
        HStack(spacing: 8) {
            DesignSystemIosAsset.Assets.icnSnow.swiftUIImage
                .resizable()
                .frame(width: 18, height: 19)
            
            Text("달성률 \(viewStore.achievementRate)%")
                .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 16).toSwiftUI)
                .foregroundColor(DesignSystemIosAsset.Assets.black20.swiftUIColor)
        }
    }
    
    private var loadingIndicator: some View {
        Group {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.7))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .foregroundColor(.black)
                .scaleEffect(2)
        }
    }
}
