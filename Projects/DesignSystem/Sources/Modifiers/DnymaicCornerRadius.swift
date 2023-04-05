//
//  DynamicCornerRadius.swift
//  DesignSystem_ios
//
//  Created by Junho Lee on 2023/04/05.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

public extension View {
    func dynamicCornerRadius() -> some View {
        self.modifier(DynamicCornerRadius())
    }
    
    func dynamicCornerRadius(isValid: Bool, _ validColor: Color, _ invalidColor: Color) -> some View {
        self.modifier(
            DynamicCornerRadiusWithColor(
                isValid: isValid, validColor: validColor, invalidColor: invalidColor
            )
        )
    }
}

struct DynamicCornerRadius: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: geometry.size.height / 2)
                        .stroke(lineWidth: 1)
                }
            )
    }
}

struct DynamicCornerRadiusWithColor: ViewModifier {
    var isValid: Bool
    var validColor: Color
    var invalidColor: Color
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: geometry.size.height / 2)
                        .stroke(
                            isValid ? validColor : invalidColor,
                            lineWidth: 1
                        )
                }
            )
    }
}
