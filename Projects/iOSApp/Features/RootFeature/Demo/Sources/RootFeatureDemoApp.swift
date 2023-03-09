import SwiftUI

import RootFeature

import ComposableArchitecture

@main
struct RootFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(
                    initialState: .init(),
                    reducer: RootCoordinator()
                )
            )
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: .init(),
                reducer: RootCoordinator()
            )
        )
    }
}
