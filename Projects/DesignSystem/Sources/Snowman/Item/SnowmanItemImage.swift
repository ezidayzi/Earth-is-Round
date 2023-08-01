//
//  SnowmanItemImage.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/12.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import Shared_ios

public struct SnowmanItemImage {
    
    let type: SnowmanItemImageType
    let snowmanType: SnowmanType
    
    struct ImageProperty {
        let size: CGSize
        let offsetX: CGFloat
        let offsetY: CGFloat
        
        var centerOffsetX: CGFloat {
            return offsetX + size.width / 2
        }
        
        var centerOffsetY: CGFloat {
            return offsetY + size.height / 2
        }
        
        static func nilProperty() -> ImageProperty {
            .init(size: CGSize(width: 0, height: 0), offsetX: 0, offsetY: 0)
        }
    }
    
    var property: ImageProperty {
        switch type {
            // Priority 1 : Eye, Mouth
        case .button:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 35, height: 12), offsetX: -27, offsetY: -23)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 35, height: 12), offsetX: -27, offsetY: -23)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 35, height: 12), offsetX: -24.5, offsetY: -20.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 35, height: 12), offsetX: -25.5, offsetY: -20.5)
            }
        case .stones:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 17), offsetX: -33, offsetY: -7)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 17), offsetX: -32.5, offsetY: -7)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 17), offsetX: -28, offsetY: -5.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 17), offsetX: -28.5, offsetY: -5.5)
            }
        case .saw:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 110, height: 90), offsetX: -110, offsetY: -79)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 110, height: 90), offsetX: -110, offsetY: -79)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 110, height: 90), offsetX: -110, offsetY: -79)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 110, height: 90), offsetX: -110, offsetY: -79)
            }
            
            // Priority 10 : Nose
        case .carrot:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 30, height: 20), offsetX: -41, offsetY: -18)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 32, height: 20), offsetX: -41, offsetY: -18)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 30, height: 20), offsetX: -36.5, offsetY: -17.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 32, height: 20), offsetX: -37.5, offsetY: -17.5)
            }
        case .radish:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 30, height: 20), offsetX: -41, offsetY: -18)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 32, height: 20), offsetX: -41, offsetY: -18)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 30, height: 20), offsetX: -36.5, offsetY: -17.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 32, height: 20), offsetX: -37.5, offsetY: -17.5)
            }
            
            // Priority 50
        case .gloves:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 150, height: 80), offsetX: -82, offsetY: -37.5)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 150, height: 80), offsetX: -82.5, offsetY: -42)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 150, height: 80), offsetX: -82, offsetY: -37.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 150, height: 80), offsetX: -80.5, offsetY: -63.5)
            }
        case .cardiganFront:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 220, height: 158), offsetX: -111, offsetY: -91.5)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 220, height: 158), offsetX: -111.5, offsetY: -66)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 220, height: 158), offsetX: -111, offsetY: -91.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 220, height: 158), offsetX: -109.5, offsetY: -87.5)
            }
        case .cardiganBack:
            switch snowmanType {
            case .largeHeadLargeBody: return .nilProperty()
            case .largeHeadSmallBody: return .nilProperty()
            case .smallHeadLargeBody: return .nilProperty()
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 100, height: 111), offsetX: -48.5, offsetY: -82.5)
            }
        case .branchLeft:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 95, height: 72), offsetX: -130, offsetY: -75.5)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 95, height: 72), offsetX: -130.5, offsetY: -72)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 95, height: 72), offsetX: -130, offsetY: -75.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 95, height: 72), offsetX: -115.5, offsetY: -71.5)
            }
        case .branchRight:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 95, height: 72), offsetX: 46, offsetY: -75.5)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 95, height: 72), offsetX: 25.5, offsetY: -72)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 95, height: 72), offsetX: 46, offsetY: -75.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 95, height: 72), offsetX: 17.5, offsetY: -71.5)
            }
            
        case .earMuffFront:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -56.5, offsetY: -97.5)
            }
        case .earMuffBack:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -72, offsetY: -40)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -71, offsetY: -40)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -72, offsetY: -40)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -70.5, offsetY: -52.5)
            }
        case .airPodMax1Front:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -56.5, offsetY: -97.5)
            }
        case .airPodMax1Back:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -72, offsetY: -40)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -71, offsetY: -40)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -72, offsetY: -40)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -70.5, offsetY: -52.5)
            }
        case .airPodMax2Front:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -56.5, offsetY: -97.5)
            }
        case .airPodMax2Back:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -72, offsetY: -40)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -71, offsetY: -40)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -72, offsetY: -40)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -70.5, offsetY: -52.5)
            }
        case .airPodMax3Front:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -57, offsetY: -85)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 128, height: 115), offsetX: -56.5, offsetY: -97.5)
            }
        case .airPodMax3Back:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -72, offsetY: -40)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -71, offsetY: -40)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -72, offsetY: -40)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 43, height: 55), offsetX: -70.5, offsetY: -52.5)
            }
            
            // Priority 70
        case .muffler1:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 127, height: 77), offsetX: -59, offsetY: 6)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 127, height: 77), offsetX: -64, offsetY: 16)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 127, height: 77), offsetX: -58.5, offsetY: -6.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 127, height: 77), offsetX: -63.5, offsetY: -6.5)
            }
        case .muffler2:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 127, height: 77), offsetX: -59, offsetY: 6)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 127, height: 77), offsetX: -64, offsetY: 16)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 127, height: 77), offsetX: -58.5, offsetY: -6.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 127, height: 77), offsetX: -63.5, offsetY: -6.5)
            }
            
            // Priority 200
        case .boots:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 169, height: 90), offsetX: -118, offsetY: -5.5)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 169, height: 90), offsetX: -118.5, offsetY: 20)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 169, height: 90), offsetX: -118, offsetY: -5.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 169, height: 90), offsetX: -116.5, offsetY: -1.5)
            }
            
            // Priority None
        case .bikini:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 115, height: 53), offsetX: -66, offsetY: -58.5)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 115, height: 53), offsetX: -66, offsetY: -43)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 115, height: 53), offsetX: -65.5, offsetY: -58.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 115, height: 53), offsetX: -64.5, offsetY: -44.5)
            }
        case .can:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 80, height: 80), offsetX: -18, offsetY: -106)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 80, height: 80), offsetX: -18, offsetY: -106)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 80, height: 80), offsetX: -24.5, offsetY: -87.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 80, height: 80), offsetX: -24.5, offsetY: -87.5)
            }
        case .santaHat:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 110, height: 110), offsetX: -30, offsetY: -138)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 110, height: 110), offsetX: -30, offsetY: -138)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 110, height: 110), offsetX: -34.5, offsetY: -120.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 110, height: 110), offsetX: -34.5, offsetY: -120.5)
            }
        case .sunglass:
            switch snowmanType {
            case .largeHeadLargeBody: return ImageProperty(size: .init(width: 52, height: 25), offsetX: -32, offsetY: -65)
            case .largeHeadSmallBody: return ImageProperty(size: .init(width: 52, height: 25), offsetX: -31.5, offsetY: -65)
            case .smallHeadLargeBody: return ImageProperty(size: .init(width: 52, height: 25), offsetX: -31, offsetY: -77.5)
            case .smallHeadSmallBody: return ImageProperty(size: .init(width: 52, height: 25), offsetX: -31.5, offsetY: -77.5)
            }
        }
    }
    
    var image: Image {
        switch type {
            // Priority 1 : Eye, Mouth
        case .button: return DesignSystemAsset.Assets.itemDrawButton.swiftUIImage
        case .stones: return DesignSystemAsset.Assets.itemDrawStones.swiftUIImage
        case .saw: return DesignSystemAsset.Assets.itemDrawSaw.swiftUIImage
            
            // Priority 10 : Nose
        case .carrot: return DesignSystemAsset.Assets.itemDrawCarrot.swiftUIImage
        case .radish: return DesignSystemAsset.Assets.itemDrawRadish.swiftUIImage
            
            // Priority 50
        case .gloves: return DesignSystemAsset.Assets.itemDrawGloves.swiftUIImage
        case .cardiganFront: return DesignSystemAsset.Assets.itemDrawCardiganFront.swiftUIImage
        case .cardiganBack: return DesignSystemAsset.Assets.itemDrawCardiganBack.swiftUIImage
        case .branchLeft: return DesignSystemAsset.Assets.itemDrawBranchBack.swiftUIImage
        case .branchRight: return DesignSystemAsset.Assets.itemDrawBranchFront.swiftUIImage
            
        case .earMuffFront: return DesignSystemAsset.Assets.itemDrawEarMuffFront.swiftUIImage
        case .earMuffBack: return DesignSystemAsset.Assets.itemDrawEarMuffBack.swiftUIImage
        case .airPodMax1Front: return DesignSystemAsset.Assets.itemDrawAirPodMax1Front.swiftUIImage
        case .airPodMax1Back: return DesignSystemAsset.Assets.itemDrawAirPodMax1Back.swiftUIImage
        case .airPodMax2Front: return DesignSystemAsset.Assets.itemDrawAirPodMax2Front.swiftUIImage
        case .airPodMax2Back: return DesignSystemAsset.Assets.itemDrawAirPodMax2Back.swiftUIImage
        case .airPodMax3Front: return DesignSystemAsset.Assets.itemDrawAirPodMax3Front.swiftUIImage
        case .airPodMax3Back: return DesignSystemAsset.Assets.itemDrawAirPodMax3Back.swiftUIImage
            
            // Priority 70
        case .muffler1: return DesignSystemAsset.Assets.itemDrawMuffler1.swiftUIImage
        case .muffler2: return DesignSystemAsset.Assets.itemDrawMuffler2.swiftUIImage
            
            // Priority 200
        case .boots: return DesignSystemAsset.Assets.itemDrawBoots.swiftUIImage
            
            // Priority None
        case .bikini: return DesignSystemAsset.Assets.itemDrawBikini.swiftUIImage
        case .can: return DesignSystemAsset.Assets.itemDrawCan.swiftUIImage
        case .santaHat: return DesignSystemAsset.Assets.itemDrawSantaHat.swiftUIImage
        case .sunglass: return DesignSystemAsset.Assets.itemDrawSunglass.swiftUIImage
        }
    }
    
    var zIndex: Double {
        switch type {
            // Priority 1 : Eye, Mouth
        case .button: return 1
        case .stones: return 1
        case .saw: return 1
            
            // Priority 10 : Nose
        case .carrot: return 10
        case .radish: return 10
            
            // Priority 50
        case .gloves: return 50
        case .cardiganFront: return 50
        case .cardiganBack: return -50
        case .branchLeft: return -10
        case .branchRight: return 50
            
        case .earMuffFront: return 50
        case .earMuffBack: return -10
        case .airPodMax1Front: return 50
        case .airPodMax1Back: return -10
        case .airPodMax2Front: return 50
        case .airPodMax2Back: return -10
        case .airPodMax3Front: return 50
        case .airPodMax3Back: return -10
            
            // Priority 70
        case .muffler1: return 70
        case .muffler2: return 70
            
            // Priority 200
        case .boots: return 200
            
            // Priority None
        case .bikini: return 100
        case .can: return 100
        case .santaHat: return 100
        case .sunglass: return 100
        }
    }
}
