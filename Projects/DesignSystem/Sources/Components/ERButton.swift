//
//  ERButton.swift
//  DesignSystem_ios
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

public struct ERButton: ButtonStyle {
    var labelColor = ERColor.Black50
    var backgroundColor = ERColor.Black90
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 18).toSwiftUI)
            .foregroundColor(labelColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
            .background(backgroundColor)
            .clipShape(Capsule())
            .dynamicCornerRadius(backgroundColor)
    }
    
    public init(
        labelColor: Color = ERColor.Black50,
        backgroundColor: Color = ERColor.Black90
    ) {
        self.labelColor = labelColor
        self.backgroundColor = backgroundColor
    }
}

extension View {
    public func erButton(
        labelColor: Color = ERColor.Black50,
        backgroundColor: Color = ERColor.Black90
    ) -> some View {
        buttonStyle(
            ERButton(
                labelColor: labelColor,
                backgroundColor: backgroundColor
            )
        )
    }
}
