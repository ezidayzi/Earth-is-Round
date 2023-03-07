import SwiftUI

import ComposableArchitecture

public struct RootView: View {
    
    let store: StoreOf<RootFeature>
    @ObservedObject var viewStore: ViewStoreOf<RootFeature>
    
    public init(store: StoreOf<RootFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        EmptyView()
    }
}
