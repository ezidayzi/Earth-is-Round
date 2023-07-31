//
//  SnowmanType.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/12.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import Shared_ios

public extension SnowmanType {

    var headSize: CGSize {
        switch self {
        case .largeHeadLargeBody, .largeHeadSmallBody:
            return CGSize(width: 117, height: 117)
        case .smallHeadLargeBody, .smallHeadSmallBody:
            return CGSize(width: 86, height: 86)
        }
    }
    
    var bodySize: CGSize {
        switch self {
        case .largeHeadLargeBody:
            return CGSize(width: 205, height: 196)
        case .largeHeadSmallBody:
            return CGSize(width: 124, height: 119)
        case .smallHeadLargeBody:
            return CGSize(width: 205, height: 196)
        case .smallHeadSmallBody:
            return CGSize(width: 98, height: 95)
        }
    }
    
    var shadowSize: CGSize {
        switch self {
        case .largeHeadLargeBody, .smallHeadLargeBody:
            return CGSize(width: 216, height: 35)
        case .largeHeadSmallBody, .smallHeadSmallBody:
            return CGSize(width: 167, height: 37)
        }
    }
    
    private var headBodyDistance: CGFloat {
        switch self {
        case .largeHeadLargeBody:
            return -37
        case .largeHeadSmallBody:
            return -24
        case .smallHeadLargeBody:
            return -34
        case .smallHeadSmallBody:
            return 12.5
        }
    }
    
    var bodyOffsetY: CGFloat {
        return headSize.height / 2
        + bodySize.height / 2
        + headBodyDistance
    }
    
    private var bodyShadowDistance: CGFloat {
        switch self {
        case .largeHeadLargeBody:
            return -16
        case .largeHeadSmallBody:
            return 43
        case .smallHeadLargeBody:
            return -16
        case .smallHeadSmallBody:
            return 34
        }
    }
    
    var shadowOffsetY: CGFloat {
        return bodyOffsetY
        + bodySize.height / 2
        + bodyShadowDistance
        + shadowSize.height / 2
    }
    
    // type별 bottom을 맞추기 위한 보정값
    var bottomAdjustment: CGFloat {
        shadowOffsetY + shadowSize.height / 2 - 200
    }
    
    var headImage: Image {
        switch self {
        case .largeHeadLargeBody, .largeHeadSmallBody:
            return DesignSystemAsset.Assets.snowmanHeadL.swiftUIImage
        case .smallHeadLargeBody, .smallHeadSmallBody:
            return DesignSystemAsset.Assets.snowmanHeadS.swiftUIImage
        }
    }
    
    var bodyImage: Image {
        switch self {
        case .largeHeadLargeBody, .smallHeadLargeBody:
            return DesignSystemAsset.Assets.snowmanBodyL.swiftUIImage
        case .largeHeadSmallBody:
            return DesignSystemAsset.Assets.snowmanBodyS.swiftUIImage
        case .smallHeadSmallBody:
            return DesignSystemAsset.Assets.snowmanBodySS.swiftUIImage
        }
    }
}
