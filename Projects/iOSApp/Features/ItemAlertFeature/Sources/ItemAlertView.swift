import SwiftUI

import ComposableArchitecture

public struct ItemAlertView: View {
    
    let store: StoreOf<ItemAlertFeature>
    @ObservedObject var viewStore: ViewStoreOf<ItemAlertFeature>
    
    public init(store: StoreOf<ItemAlertFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        EmptyView()
    }
}
