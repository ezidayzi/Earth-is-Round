//
//  TitleTextField.swift
//  AuthFeature
//
//  Created by Junho Lee on 2023/04/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import Shared_ios
import DesignSystem_ios

@ViewBuilder
func titleTextField(
    title: String,
    placeHolder: String,
    text: Binding<String>,
    isValid: Bool,
    maxLength: Int
) -> some View {
    VStack(alignment: .leading) {
        Text(title)
            .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 16).toSwiftUI)
            .foregroundColor(ERColor.Black10)
            .padding(.leading, 12.adjusted)
        ERTextField(
            text: text,
            isValid: isValid,
            maxLength: maxLength,
            placeholder: placeHolder
        )
    }
}

@ViewBuilder
func titleSecureField(
    title: String,
    placeHolder: String,
    text: Binding<String>,
    isValid: Bool,
    maxLength: Int
) -> some View {
    VStack(alignment: .leading) {
        Text(title)
            .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 16).toSwiftUI)
            .foregroundColor(ERColor.Black10)
            .padding(.leading, 12.adjusted)
        ERSecureField(
            text: text,
            isValid: isValid,
            maxLength: maxLength,
            placeholder: placeHolder
        )
    }
}
