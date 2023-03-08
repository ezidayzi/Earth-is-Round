//
//  SplashView.swift
//  SplashFeature
//
//  Created by Junho Lee on 2023/03/08.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct SplashView: View {
    
    let store: StoreOf<SplashFeature>
    @ObservedObject var viewStore: ViewStoreOf<SplashFeature>
    
    public init(store: StoreOf<SplashFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            Text("Splash View")
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            Color(.yellow)
        )
        .onAppear {
            Task {
                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    viewStore.send(.splashAnimationFinished, animation: .default)
                } catch {
                    
                }
            }
        }
    }
}
