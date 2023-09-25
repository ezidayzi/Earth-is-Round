//
//  SnowmanItemType+.swift
//  DesignSystem
//
//  Created by 김윤서 on 2023/09/25.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Shared_ios
import SwiftUI

extension SnowmanItemType {
    var image: Image {
        switch self {
        case .button: return DesignSystemAsset.Assets.itemDrawButton.swiftUIImage
        case .stones:return DesignSystemAsset.Assets.itemDrawStones.swiftUIImage
        case .saw: return DesignSystemAsset.Assets.itemDrawSaw.swiftUIImage
        case .carrot: return DesignSystemAsset.Assets.itemDrawCarrot.swiftUIImage
        case .radish: return DesignSystemAsset.Assets.itemDrawRadish.swiftUIImage
        case .gloves: return DesignSystemAsset.Assets.itemDrawGloves.swiftUIImage
        case .cardigan: return DesignSystemAsset.Assets.itemDrawCardiganFront.swiftUIImage
        case .branch: return DesignSystemAsset.Assets.itemDrawBranchBack.swiftUIImage
        case .earMuff: return DesignSystemAsset.Assets.itemDrawEarMuffFront.swiftUIImage
        case .airPodMax1: return DesignSystemAsset.Assets.itemDrawAirPodMax1Front.swiftUIImage
        case .airPodMax2: return DesignSystemAsset.Assets.itemDrawAirPodMax2Front.swiftUIImage
        case .airPodMax3: return DesignSystemAsset.Assets.itemDrawAirPodMax3Front.swiftUIImage
        case .muffler1: return DesignSystemAsset.Assets.itemDrawMuffler1.swiftUIImage
        case .muffler2: return DesignSystemAsset.Assets.itemDrawMuffler2.swiftUIImage
        case .boots: return DesignSystemAsset.Assets.itemDrawBoots.swiftUIImage
        case .bikini: return DesignSystemAsset.Assets.itemDrawBikini.swiftUIImage
        case .can: return DesignSystemAsset.Assets.itemDrawCan.swiftUIImage
        case .santaHat: return DesignSystemAsset.Assets.itemDrawSantaHat.swiftUIImage
        case .sunglass: return DesignSystemAsset.Assets.itemDrawSunglass.swiftUIImage

        }
    }
}
