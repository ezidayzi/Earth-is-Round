import SwiftUI

import SplashFeature

import ComposableArchitecture

@main
struct SplashFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(
                store: Store(
                    initialState: .init(),
                    reducer: SplashFeature()
                )
            )
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(
            store: Store(
                initialState: .init(),
                reducer: SplashFeature()
            )
        )
    }
}
