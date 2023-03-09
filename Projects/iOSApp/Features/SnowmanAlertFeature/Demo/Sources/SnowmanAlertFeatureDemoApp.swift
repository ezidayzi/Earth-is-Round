import SwiftUI

import SnowmanAlertFeature

import ComposableArchitecture

@main
struct SnowmanAlertFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            SnowmanAlertView(
                store: Store(
                    initialState: .init(),
                    reducer: SnowmanAlertFeature()
                )
            )
        }
    }
}

struct SnowmanAlertView_Previews: PreviewProvider {
    static var previews: some View {
        SnowmanAlertView(
            store: Store(
                initialState: .init(),
                reducer: SnowmanAlertFeature()
            )
        )
    }
}
