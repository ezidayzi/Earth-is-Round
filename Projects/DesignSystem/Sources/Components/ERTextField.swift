//
//  ERTextField.swift
//  DesignSystem_ios
//
//  Created by Junho Lee on 2023/04/04.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

public struct ERTextField: View {
    @Binding private var text: String
    private var isValid: Bool
    private var maxLength: Int
    private var placeholder: String
    @FocusState private var isFocused: Bool
    
    public init(
        text: Binding<String>,
        isValid: Bool,
        maxLength: Int,
        placeholder: String
    ) {
        self._text = text
        self.isValid = isValid
        self.maxLength = maxLength
        self.placeholder = placeholder
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            if(text.isEmpty && !isFocused) {
                Text(placeholder)
                    .foregroundColor(ERColor.Black50)
            }
            TextField("", text: $text, prompt: Text(placeholder))
                .focused($isFocused)
                .onChange(of: text) { newValue in
                    text = String(newValue.prefix(maxLength))
                }
        }
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
        .background(ERColor.Black90)
        .clipShape(Capsule())
        .dynamicCornerRadius(isValid: isValid, ERColor.Alert, ERColor.Black90)
    }
}
