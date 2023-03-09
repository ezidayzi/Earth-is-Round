import SwiftUI

import ComposableArchitecture

public struct SettingView: View {
    
    let store: StoreOf<SettingFeature>
    @ObservedObject var viewStore: ViewStoreOf<SettingFeature>
    
    public init(store: StoreOf<SettingFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        EmptyView()
    }
}
