import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

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
            IfLet(viewStore.steps) { steps in
                Text("\(steps) 만큼 걸음")
            } elseContent: {
                Text("걸음 수 접근 권한이 없습니다.")
            }
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
