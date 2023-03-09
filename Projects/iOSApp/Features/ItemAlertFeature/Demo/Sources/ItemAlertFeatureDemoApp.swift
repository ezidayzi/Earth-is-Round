import SwiftUI

import ItemAlertFeature

import ComposableArchitecture

@main
struct ItemAlertFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ItemAlertView(
                store: Store(
                    initialState: .init(),
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
                initialState: .init(),
                reducer: ItemAlertFeature()
            )
        )
    }
}
