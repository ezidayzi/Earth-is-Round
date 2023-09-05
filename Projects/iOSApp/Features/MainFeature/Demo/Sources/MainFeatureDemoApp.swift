import SwiftUI

import MainFeature

import ComposableArchitecture

@main
struct MainFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                store: Store(
                    initialState: MainFeature.State(currentWeekDay: 18, pastSteps: [13, 15, 400]),
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
                initialState: MainFeature.State(currentWeekDay: 18, pastSteps: [13, 15, 400]),
                reducer: MainFeature()
            )
        )
    }
}
