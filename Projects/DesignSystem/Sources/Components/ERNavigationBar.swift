//
//  ERNavigationBar.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/05/27.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import Shared_ios

public struct ERNavigationBar: View {
    
    let action: (() -> Void)?
    let title: String
    let backgroundColor: Color
    
    public init(
        title: String,
        backgroundColor: Color = ERColor.White,
        action: (() -> Void)? = nil
    ) {
        self.action = action
        self.backgroundColor = backgroundColor
        self.title = title
    }

    public var body: some View {
        HStack(spacing: 7.adjusted) {
            Button(action: {
                action?()
            }) {
                DesignSystemIosAsset.Assets.icnBackArrow.swiftUIImage
                    .padding(.leading, 19.adjusted)
            }
            
            Text(title)
                .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 18).toSwiftUI)
                .foregroundColor(ERColor.Black10)
                .padding(.vertical, 10)
            
            Spacer()
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
    }
}
