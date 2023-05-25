//
//  WeeklyWalkView.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/05/25.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import shared_watchOS
#endif

/// WeeklyWalkVIew : 주간 걸음 수 확인 뷰
public struct WeeklyWalkView: View {
    
    let steps: [Int]
    let dayLabels = ["월", "화", "수", "목", "금", "토", "일"]
    @State private var selectedIndex = -1
    private let spacing: CGFloat = 16
    private let padding: CGFloat = 16
    private let standard: Int
    
    public init(steps: [Int], standard: Int = 5000) {
        assert(steps.count <= 7, "배열의 길이는 7 이하여야 합니다.")
        self.steps = steps
        self.standard = standard
    }
    
    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: spacing) {
                ForEach(0..<7) { index in
                    VStack {
                        if index < steps.count {
                            circleImage(viewWidth: geometry.size.width, index: index)
                        }
                        
                        Text(dayLabels[index])
                            .foregroundColor(ERColor.Black50)
                            .font(DesignSystemIosFontFamily.AritaDotumOTF.medium.font(size: 12).toSwiftUI)
                    }
                    .frame(width: calculateMaxCircleSize(viewWidth: geometry.size.width))
                }
            }
            .padding(.horizontal, padding)
            // HStack의 영역을 벗어나야 하기 때문에 overlay 사용
            .overlay {
                if selectedIndex != -1 {
                    Text(steps[selectedIndex].decimal)
                        .font(DesignSystemIosFontFamily.AritaDotumOTF.semiBold.font(size: 13).toSwiftUI)
                        .foregroundColor(ERColor.White)
                        .padding(.horizontal, 10)
                        .frame(height: 24)
                        .background(
                            Capsule()
                                .foregroundColor(ERColor.Main)
                        )
                        .position(
                            x: padding
                            + calculateMaxCircleSize(viewWidth: geometry.size.width) * (CGFloat(selectedIndex) + 0.5)
                            + spacing * CGFloat(selectedIndex),
                            y: -20
                        )
                }
            }
        }
    }
    
    @ViewBuilder
    private func circleImage(viewWidth: CGFloat, index: Int) -> some View {
        let maxCircleSize = calculateMaxCircleSize(viewWidth: viewWidth)
        let calculatedSize = calculateCircleSize(maxCircleSize: maxCircleSize, index: index)
        Circle()
            .foregroundColor(selectedIndex == index ? .blue : .gray)
            .frame(
                width: min(maxCircleSize, calculatedSize),
                height: min(maxCircleSize, calculatedSize)
            )
            .onTapGesture {
                selectedIndex = index
            }
    }
}

// MARK: - Private Methods

extension WeeklyWalkView {
    private func calculateCircleSize(maxCircleSize: CGFloat, index: Int) -> CGFloat {
        return CGFloat(steps[index]) / CGFloat(standard) * maxCircleSize
    }
    
    private func calculateMaxCircleSize(viewWidth: CGFloat) -> CGFloat {
        let totalCircleWidth = viewWidth - spacing * 6 - padding * 2
        return totalCircleWidth / 7
    }
}
