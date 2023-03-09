import SwiftUI

import MainFeature

import ComposableArchitecture

@main
struct MainFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                store: Store(
                    initialState: MainFeature.State(),
                    reducer: MainFeature()
                )
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(
                initialState: MainFeature.State(),
                reducer: MainFeature()
            )
        )
    }
}
