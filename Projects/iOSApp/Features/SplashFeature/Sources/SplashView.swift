//
//  SplashView.swift
//  SplashFeature
//
//  Created by Junho Lee on 2023/03/08.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

import Shared_ios
import DesignSystem_ios

public struct SplashView: View {
    
    let store: StoreOf<SplashFeature>
    @ObservedObject var viewStore: ViewStoreOf<SplashFeature>
    
    public init(store: StoreOf<SplashFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            Spacer(minLength: 336 - 44)
            DesignSystemIosAsset.Assets.splashTitle.swiftUIImage
            Spacer()
            Text("@2023.earthisround All rights reserved.")
                .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 15).toSwiftUI)
                .foregroundColor(ERColor.Black10)
                .frame(width: 250, height: 15)
                .background(Color.white)
            Spacer(minLength: 65)
        }
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
