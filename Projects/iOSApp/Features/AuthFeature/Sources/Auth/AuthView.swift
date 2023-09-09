//
//  AuthView.swift
//  AuthFeature
//
//  Created by Junho Lee on 2023/04/25.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

import DesignSystem_ios

public struct AuthView: View {
    
    private enum Metric {
        static let imageButtonSpacing = 295.adjustedH
        static let buttonSpacing = 20.adjustedH
        static let buttonBottomPadding = (62 - 34).adjustedH
    }
    
    let store: StoreOf<AuthFeature>
    @ObservedObject var viewStore: ViewStoreOf<AuthFeature>
    
    public init(store: StoreOf<AuthFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            Spacer()
            
            DesignSystemIosAsset.Assets.logoTitle.swiftUIImage
            
            Spacer()
                .frame(height: Metric.imageButtonSpacing)
            
            VStack(spacing: Metric.buttonSpacing) {
                Button("회원가입") {
                    viewStore.send(.coordinator(.signUp))
                }
                .erButton(labelColor: ERColor.White, backgroundColor: ERColor.Main)
                
                Button("로그인") {
                    viewStore.send(.coordinator(.signIn))
                }
                .erButton(labelColor: ERColor.Black10, backgroundColor: ERColor.White)
                .dynamicCornerRadius(ERColor.Black70)
            }
            .horizontalPadding()
            
            Spacer()
                .frame(height: Metric.buttonBottomPadding)
        }
    }
}

