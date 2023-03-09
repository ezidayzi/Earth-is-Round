import SwiftUI

import ComposableArchitecture

import RootFeature

@main
struct EarthIsRoundApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView(
                store: appDelegate.store.scope(
                    state: \.rootCoordinator,
                    action: AppFeature.Action.rootCoordinator
                )
            )
        }
    }
}
