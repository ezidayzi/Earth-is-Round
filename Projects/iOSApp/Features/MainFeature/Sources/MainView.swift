import SwiftUI

import ComposableArchitecture

public struct MainView: View {
    
    let store: StoreOf<MainFeature>
    @ObservedObject var viewStore: ViewStoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            Text("Main View")
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            Color(.brown)
        )
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}
