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

            snowmanItems
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
    }

    private var mainContent: some View {
        VStack {
            logoNavigationBar

            Spacer()
                .frame(height: 42.adjustedH)

            weekDayButton
                .padding(.leading, 20)

            stepsContent
                .padding(.top, 40.adjustedH)
                .padding(.leading, 20)

            /// - Note (230730) @Duno
            /// Lottie File의 영역이 부정확하게 잡혀 있음. 디자인 요청 필요.
            ERSnowBall(animationSpeed: viewStore.binding(\.$currentSpeed))
                .frame(height: 300)

            achievementRateView
                .padding(.top, 34)
                .padding(.bottom, 14)

            snowmanButton
                .padding(.bottom, 62.adjustedH)
        }
        .ignoresSafeArea(edges: .top)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(DesignSystemIosAsset.Assets.backgroundBlue.swiftUIColor)
    }

    private var logoNavigationBar: some View {
        ZStack {
            HStack {
                Spacer()
                Image(asset: DesignSystemAsset.Assets.logoTitle)
                    .resizable()
                    .frame(width: 118, height: 17)
                Spacer()
            }

            HStack {
                Spacer()
                Button(action: {
                    viewStore.send(.settingButtonTapped)
                }) {
                    DesignSystemIosAsset.Assets.icnSetting.swiftUIImage
                }
                .padding(.trailing, 14)
            }
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
    }

    private var weekDayButton: some View {
        HStack {
            HStack(spacing: 12) {
                Button(action: {
                    viewStore.send(.prevButtonTapped)
                }) {
                    DesignSystemIosAsset.Assets.icnLeftArrow.swiftUIImage
                        .renderingMode(.template)
                        .foregroundColor(viewStore.prevButtonEnabled ? .blue : .gray)
                        .frame(width: 18, height: 18)
                }
                .disabled(!viewStore.prevButtonEnabled)

                Text(viewStore.weekDayString)
                    .offset(x: -3)

                Button(action: {
                    viewStore.send(.nextButtonTapped)
                }) {
                    DesignSystemIosAsset.Assets.icnRightArrow.swiftUIImage
                        .renderingMode(.template)
                        .foregroundColor(viewStore.nextButtonEnabled ? .blue : .gray)
                }
                .disabled(!viewStore.nextButtonEnabled)
            }
            Spacer()
        }
    }

    private var stepsContent: some View {
        HStack {
            stepsText
            Spacer()
        }
        .padding(.leading)
    }

    private var stepsText: some View {
        IfLet(viewStore.displayedSteps) { steps in
            VStack(alignment: .leading) {
                Text("오늘은")
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 17).toSwiftUI)
                    .foregroundColor(DesignSystemIosAsset.Assets.black10.swiftUIColor)
                    .padding(.bottom, 6)
                Text("\(steps)보")
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.bold.font(size: 32).toSwiftUI)
                    .foregroundColor(DesignSystemIosAsset.Assets.black10.swiftUIColor)
                    .padding(.bottom, 8)
                Text("굴러가는 중")
                    .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 32).toSwiftUI)
                    .foregroundColor(DesignSystemIosAsset.Assets.black10.swiftUIColor)
            }
        } elseContent: {
            Text("걸음 수 접근 권한이 없습니다.")
        }
    }

    private var snowmanButton: some View {
        Button("내 눈사람", action: {
            viewStore.send(.mySnowmanButtonTapped)
        })
        .erButton(
            labelColor: DesignSystemIosAsset.Assets.white.swiftUIColor,
            backgroundColor: DesignSystemIosAsset.Assets.main.swiftUIColor
        )
        .frame(width: 141)
    }

    private var snowmanItems: some View {
        ForEach(viewStore.snowmanItemPoints.indices, id: \.self) { index in
            let item = viewStore.snowmanItemPoints[index]
            let imageSize: CGFloat = 130
            let minX: CGFloat = imageSize / 2
            let maxX: CGFloat = UIScreen.main.bounds.width - imageSize / 2
            let minY: CGFloat = 298.adjustedH -  imageSize / 2
            let maxY: CGFloat = UIScreen.main.bounds.height - imageSize / 2

            let dragGesture = DragGesture()
                .onChanged { value in
                    var newX = value.location.x
                    var newY = value.location.y

                    newX = min(maxX, max(minX, newX))
                    newY = min(maxY, max(minY, newY))

                    viewStore.send(.updateSnowmanItemPosition(index: index, x: newX, y: newY))
                }
                .onEnded { value in
                    viewStore.send(.saveSnowmanItemPositoion(index: index, x:  value.location.x, y: value.location.y))
                }

            item.itemType.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageSize, height: imageSize)
                .position(x: item.x, y: item.y)
                .gesture(dragGesture)
        }

    }

    private var achievementRateView: some View {
        Text("달성률 \(viewStore.achievementRate)%")
            .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 16).toSwiftUI)
            .foregroundColor(DesignSystemIosAsset.Assets.black20.swiftUIColor)
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

extension CGSize {
  static func + (lhs: Self, rhs: Self) -> Self {
    CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
  }
}
