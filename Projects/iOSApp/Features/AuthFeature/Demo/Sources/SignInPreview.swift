//
//  SignInPreview.swift
//  AuthFeatureDemo
//
//  Created by Junho Lee on 2023/03/10.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

import AuthFeature

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(
            store: Store(
                initialState: .init(),
                reducer: SignInFeature()
            )
        )
    }
}
