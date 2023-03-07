import SwiftUI

import ComposableArchitecture

public struct ArchiveView: View {
    
    let store: StoreOf<ArchiveFeature>
    @ObservedObject var viewStore: ViewStoreOf<ArchiveFeature>
    
    public init(store: StoreOf<ArchiveFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        EmptyView()
    }
}
