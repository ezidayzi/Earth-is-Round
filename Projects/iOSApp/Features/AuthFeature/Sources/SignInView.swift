import SwiftUI

import ComposableArchitecture

public struct SignInView: View {
    
    let store: StoreOf<SignInFeature>
    @ObservedObject var viewStore: ViewStoreOf<SignInFeature>
    
    public init(store: StoreOf<SignInFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            Text("SignIn View")
            Button {
                viewStore.send(.signInButtonTapped, animation: .default)
            } label: {
                Text("로그인 하기")
            }
        }
    }
}
