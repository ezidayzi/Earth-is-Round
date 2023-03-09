import SwiftUI

import ArchiveFeature

import ComposableArchitecture

@main
struct ArchiveFeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ArchiveView(
                store: Store(
                    initialState: .init(),
                    reducer: ArchiveFeature()
                )
            )
        }
    }
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView(
            store: Store(
                initialState: .init(),
                reducer: ArchiveFeature()
            )
        )
    }
}
