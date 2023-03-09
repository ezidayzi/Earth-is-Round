import SwiftUI

import AuthFeature

import ComposableArchitecture

@main
struct AuthFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            SignInView(
                store: Store(
                    initialState: .init(),
                    reducer: SignInFeature()
                )
            )
        }
    }
}
