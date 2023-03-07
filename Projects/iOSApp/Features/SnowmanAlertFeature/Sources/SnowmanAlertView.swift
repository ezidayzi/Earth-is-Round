import SwiftUI

import ComposableArchitecture

public struct SnowmanAlertView: View {
    
    let store: StoreOf<SnowmanAlertFeature>
    @ObservedObject var viewStore: ViewStoreOf<SnowmanAlertFeature>
    
    public init(store: StoreOf<SnowmanAlertFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        EmptyView()
    }
}
