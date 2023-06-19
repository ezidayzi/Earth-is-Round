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
    
    public init(itemRawValues: [Int], snowmanType: SnowmanType) {
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
                
                Group {
                    // 그림자
                    Ellipse()
                        .fill(ERColor.Black70.opacity(0.6))
                        .frame(width: snowmanType.shadowSize.width * scaleFactor, height: snowmanType.shadowSize.height * scaleFactor)
                        .offset(y: snowmanType.shadowOffsetY * scaleFactor)
                        .zIndex(-100)
                    
                    // 눈사람 몸통
                    snowmanType.bodyImage
                        .resizable()
                        .frame(width: snowmanType.bodySize.width * scaleFactor, height: snowmanType.bodySize.height * scaleFactor)
                        .offset(y: snowmanType.bodyOffsetY * scaleFactor)
                    
                    // 눈사람 머리
                    snowmanType.headImage
                        .resizable()
                        .frame(width: snowmanType.headSize.width * scaleFactor, height: snowmanType.headSize.height * scaleFactor)
                    
                    // Items
                    ForEach(items, id: \.type) { item in
                        itemImage(item, by: scaleFactor)
                    }
                    
                }.offset(y: -snowmanType.bottomAdjustment * scaleFactor)
            }
        }
    }
    
    /// - NOTE(230611)
    /// 아래와 같이 분리하지 않으면 컴파일러 에러 발생. 컴파일러 성능 한계.
    @ViewBuilder
    private func itemImage(_ item: SnowmanItem, by scaleFactor: CGFloat) -> some View {
        let bodyItemAdjustment: CGFloat = item.attachmentPoint == .head
        ? 0 : snowmanType.bodyOffsetY * scaleFactor
        ForEach(item.getImages(by: snowmanType), id: \.type) { itemImage in
            let offSetX = itemImage.property.centerOffsetX * scaleFactor
            let offSetY = itemImage.property.centerOffsetY * scaleFactor + bodyItemAdjustment
            itemImage.image
                .resizable()
                .frame(width: itemImage.property.size.width * scaleFactor, height: itemImage.property.size.height * scaleFactor)
                .offset(x: offSetX, y: offSetY)
                .zIndex(itemImage.zIndex)
        }
    }
}
