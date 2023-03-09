import SwiftUI

import SettingFeature

import ComposableArchitecture

@main
struct SettingFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            SettingView(
                store: Store(
                    initialState: .init(),
                    reducer: SettingFeature()
                )
            )
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(
            store: Store(
                initialState: .init(),
                reducer: SettingFeature()
            )
        )
    }
}
