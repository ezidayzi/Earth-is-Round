import SwiftUI

import ComposableArchitecture
import DesignSystem_ios

public struct ArchiveView: View {
    
    let store: StoreOf<ArchiveFeature>
    @ObservedObject var viewStore: ViewStoreOf<ArchiveFeature>

    public init(store: StoreOf<ArchiveFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack(spacing: 0) {
            ERNavigationBar(title: "내 눈사람", action: {
                viewStore.send(.naviBackButtonTapped)
            })
            ScrollView {
                LazyVGrid(columns: (1...2).map { _ in return GridItem(.flexible()) }, spacing: 6) {
                    ForEach(viewStore.archiveList ?? [], id: \.self) { mothlyArchive in
                        Section(content: {
                            ForEach(mothlyArchive.weeklyArchive, id: \.self) { weeklyArchive in
                                ArchiveGridItem(
                                    week: "\(weeklyArchive.week)주차",
                                    snowmanType: weeklyArchive.snowmanType,
                                    snowmanItemType: weeklyArchive.snowmanItem
                                )
                            }
                        }, header: {
                            HStack {
                                Text("\(mothlyArchive.month)월")
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
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}

fileprivate struct ArchiveGridItem: View {
    let week: String
    let snowmanType: SnowmanType
    let snowmanItemType: [SnowmanItemType]

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(ERColor.Black90)
                .overlay {
                    SnowmanView(
                        itemRawValues: snowmanItemType.map { $0.rawValue },
                        snowmanType: snowmanType
                    )
                    .padding(.init(top: 36, leading: 16, bottom: 20, trailing: 16))
                    .frame(width: geometry.size.width)
                    .frame(height: geometry.size.width * 4/3)
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

