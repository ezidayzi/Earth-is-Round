import SwiftUI

import ComposableArchitecture
import DesignSystem_ios
import Shared_ios

public struct ArchiveView: View {
    
    let store: StoreOf<ArchiveFeature>
    @ObservedObject var viewStore: ViewStoreOf<ArchiveFeature>
    @State private var isArchiveListEmpty = true

    public init(store: StoreOf<ArchiveFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            ERNavigationBar(
                title: I18N.Archive.mySnowman,
                backgroundColor: isArchiveListEmpty ? ERColor.Black90 : ERColor.White
            ) {
                viewStore.send(.naviBackButtonTapped)
            }

            if let archiveList = viewStore.archiveList, !archiveList.isEmpty {
                ScrollView {
                    LazyVGrid(columns: (1...2).map { _ in return GridItem(.flexible()) }, spacing: 6) {
                        ForEach(viewStore.archiveList ?? [], id: \.self) { mothlyArchive in
                            Section(content: {
                                ForEach(mothlyArchive.weeklyArchive, id: \.self) { weeklyArchive in
                                    ArchiveGridItem(
                                        week: "\(weeklyArchive.week)\(I18N.Common.week)",
                                        snowmanType: weeklyArchive.snowmanType,
                                        snowmanItemTypes: weeklyArchive.snowmanItemTypes
                                    )
                                }
                            }, header: {
                                HStack {
                                    Text("\(mothlyArchive.month)\(I18N.Common.month)")
                                        .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 18).toSwiftUI)
                                    Spacer()
                                }
                                .frame(height: 60)
                            })
                        }
                    }
                    .padding(16)
                }
                .scrollIndicators(.hidden)
            } else {
                SnowmanEmptyView()
                    .padding()
            }
        }
        .background(isArchiveListEmpty ? ERColor.Black90 : ERColor.White)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .onChange(of: viewStore.archiveList) { _ in
            updateArchiveListEmpty()
        }
    }

    private func updateArchiveListEmpty() {
        isArchiveListEmpty = viewStore.archiveList?.isEmpty ?? true
    }
}

fileprivate struct ArchiveGridItem: View {
    let week: String
    let snowmanType: SnowmanType
    let snowmanItemTypes: [SnowmanItemType]

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(ERColor.Blue80)
                .overlay {
                    SnowmanView(
                        itemRawValues: snowmanItemTypes.map { $0.rawValue },
                        snowmanType: snowmanType
                    )
                    .frame(width: geometry.size.width - 32)
                    .frame(height: (geometry.size.width - 32) * 4/3)
                }

            Text(week)
                .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 13).toSwiftUI)
                .foregroundColor(Color.black)
                .padding(.init(top: 3, leading: 7, bottom: 3, trailing: 7))
                .background {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .fill(ERColor.White)
                }
                .offset(x: 11, y: 11)
        }
        .aspectRatio(160/205, contentMode: .fit)
        .cornerRadius(6)

    }
}

fileprivate struct SnowmanEmptyView: View {

    private enum Metric {
        static let snowmanImageSize: CGFloat = 88
        static let speechBalloonHeight: CGFloat = 108
        static let imageHeight = snowmanImageSize + speechBalloonHeight
    }

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: (geo.size.height - Metric.imageHeight) * 2 / 5)
                Group {
                    ERSpeechBalloon(text: {
                        Text("눈사람 is empty")
                            .foregroundColor(ERColor.Black50)
                    }, color: ERColor.White)
                    .padding(.horizontal,100)
                    .frame(maxHeight: Metric.speechBalloonHeight)

                    ZStack {
                        Rectangle()
                            .fill(.clear)
                        Image(asset: DesignSystemIosAsset.Assets.itemDrawButton)
                            .resizable()
                            .frame(width: 35, height: 12)
                            .offset(x: 5, y: -14)
                        Image(asset: DesignSystemIosAsset.Assets.itemDrawCarrot)
                            .resizable()
                            .frame(width: 30, height: 20)
                            .offset(x: -11, y: -5)
                        Image(asset: DesignSystemIosAsset.Assets.itemDrawStones)
                            .resizable()
                            .frame(width: 43, height: 17)
                            .offset(x: 2, y: 8)
                    }
                    .frame(
                        width: Metric.snowmanImageSize,
                        height: Metric.snowmanImageSize,
                        alignment: .topLeading)
                    .offset(y: -10)
                }
                Spacer()
                    .frame(height: (geo.size.height - Metric.imageHeight)  * 3 / 5)
            }
        }
    }
}
