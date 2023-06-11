//
//  Snowman.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/11.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

public struct SnowmanView: View {
    
    let items: [SnowmanItem]
    let snowmanType: SnowmanType
    
    /// - Note(230611)
    /// Width 300 / Height 400 기준
    var widthHeightRatio: CGFloat {
        return 300.0 / 400.0
    }
    
    init(itemRawValues: [Int], snowmanType: SnowmanType) {
        self.items = itemRawValues
            .compactMap { SnowmanItemType(rawValue: $0) }
            .map { SnowmanItem(type: $0) }
        self.snowmanType = snowmanType
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = height * widthHeightRatio
            let scaleFactor = height / 400
            
            ZStack {
                Spacer()
                    .frame(width: width, height: height)
                    .zIndex(-101)
                
                // 그림자
                Group {
                    Ellipse()
                        .fill(Color.gray)
                        .frame(width: snowmanType.shadowSize.width * scaleFactor, height: snowmanType.shadowSize.height * scaleFactor)
                        .offset(y: snowmanType.shadowOffsetY * scaleFactor)
                        .zIndex(-100)
                    
                    // 아이템의 backImage 배치
                    ForEach(items, id: \.type) { item in
                        backImage(item, by: scaleFactor)
                    }
                    
                    // 눈사람 몸통
                    Circle()
                        .fill(Color.gray)
                        .frame(width: snowmanType.bodySize.width * scaleFactor, height: snowmanType.bodySize.height * scaleFactor)
                        .offset(y: snowmanType.bodyOffsetY * scaleFactor)
                    
                    // 눈사람 머리
                    Circle()
                        .fill(Color.gray)
                        .frame(width: snowmanType.headSize.width * scaleFactor, height: snowmanType.headSize.height * scaleFactor)
                    
                    // 아이템의 frontImage 배치
                    ForEach(items, id: \.type) { item in
                        frontImage(item, by: scaleFactor)
                    }
                }.offset(y: -snowmanType.bottomAdjustment * scaleFactor)
            }
        }
    }
    
    /// - NOTE(230611)
    /// 아래와 같이 분리하지 않으면 컴파일러 에러 발생. 컴파일러 성능 한계.
    @ViewBuilder
    private func backImage(_ item: SnowmanItem, by scaleFactor: CGFloat) -> some View {
        if let backImage = item.backImage {
            let bodyItemAdjustment: CGFloat = item.attachmentPoint == .head
            ? 0 : snowmanType.bodyOffsetY * scaleFactor
            let offSetX = item.positionFromCenter.x * scaleFactor
            let offSetY = item.positionFromCenter.y * scaleFactor + bodyItemAdjustment
            backImage
                .resizable()
                .frame(width: item.width * scaleFactor, height: item.height * scaleFactor)
                .offset(
                    x: offSetX,
                    y: offSetY
                )
        }
    }
    
    @ViewBuilder
    private func frontImage(_ item: SnowmanItem, by scaleFactor: CGFloat) -> some View {
        let bodyItemAdjustment: CGFloat = item.attachmentPoint == .head
        ? 0 : snowmanType.bodyOffsetY * scaleFactor
        let offSetX = item.positionFromCenter.x * scaleFactor
        let offSetY = item.positionFromCenter.y * scaleFactor + bodyItemAdjustment
        item.frontImage
            .resizable()
            .frame(width: item.width * scaleFactor, height: item.height * scaleFactor)
            .offset(
                x: offSetX,
                y: offSetY
            )
    }
}

