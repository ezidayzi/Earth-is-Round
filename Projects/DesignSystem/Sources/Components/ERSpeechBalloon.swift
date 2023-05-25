//
//  ERSpeechBalloon.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/05/25.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

/// ERSpeechBalloon
/// .frame의 height를 통해 동적으로 뷰 크기 변경
/// 확장성을 위해 Text를 생성 파라미터로 사용
public struct ERSpeechBalloon: View {
    let text: () -> Text
    let color: Color
    
    public init(
        @ViewBuilder text: @escaping () -> Text,
        color: Color
    ) {
        self.text = text
        self.color = color
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                Capsule()
                    .fill(color)
                    .frame(
                        width: .infinity,
                        height: geometry.size.height * 51 / 108
                    )
                    .overlay(text())
                    .padding(.bottom, geometry.size.height * 7 / 108)

                HStack {
                    Circle()
                        .fill(color)
                        .frame(
                            width: geometry.size.height * 20 / 108,
                            height: geometry.size.height * 20 / 108,
                            alignment: .leading
                        )
                    
                    Spacer()
                }
                .padding(.bottom, geometry.size.height * 3 / 108)
                
                HStack {
                    Circle()
                        .fill(color)
                        .frame(
                            width: geometry.size.height * 15 / 108,
                            height: geometry.size.height * 15 / 108,
                            alignment: .leading
                        )
                        .padding(.leading, geometry.size.height * 10 / 108)
                    
                    Spacer()
                }
            }
        }
    }
}
