import SwiftUI

import ItemAlertFeature

import ComposableArchitecture

import LocalStorageClient_ios
import Shared_ios

@main
struct ItemAlertFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ItemAlertView(
                store: Store(
                    initialState: .init(
                        snowmanItem: SnowmanItemInfo(
                            date: "12월 6일",
                            itemPoint: [
                                ItemPoint(itemType: SnowmanItemType.airPodMax1, x: 50, y: 50),
                                ItemPoint(itemType: SnowmanItemType.airPodMax1, x: 50, y: 50),
                                ItemPoint(itemType: SnowmanItemType.airPodMax1, x: 50, y: 50),
                                ItemPoint(itemType: SnowmanItemType.airPodMax1, x: 50, y: 50),
                            ]
                        )
                    ),
                    reducer: ItemAlertFeature()
                )
            )
        }
    }
}

struct ItemAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ItemAlertView(
            store: Store(
                initialState: .init(
                    snowmanItem: SnowmanItemInfo(
                        date: "12월 6일",
                        itemPoint: [
                            ItemPoint(itemType: SnowmanItemType.airPodMax1, x: 50, y: 50),
                            ItemPoint(itemType: SnowmanItemType.airPodMax1, x: 50, y: 50),
                            ItemPoint(itemType: SnowmanItemType.airPodMax1, x: 50, y: 50),
                            ItemPoint(itemType: SnowmanItemType.airPodMax1, x: 50, y: 50),
                        ]
                    )
                ),
                reducer: ItemAlertFeature()
            )
        )
    }
}
