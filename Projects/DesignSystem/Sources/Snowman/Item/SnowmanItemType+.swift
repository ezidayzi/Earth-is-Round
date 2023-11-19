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
    public var image: Image {
        switch self {
        case .button: return DesignSystemAsset.Assets.stickerButton.swiftUIImage
        case .stones:return DesignSystemAsset.Assets.stickerStones.swiftUIImage
        case .saw: return DesignSystemAsset.Assets.itemDrawSaw.swiftUIImage
        case .carrot: return DesignSystemAsset.Assets.stickerCarrot.swiftUIImage
        case .radish: return DesignSystemAsset.Assets.stickerCarrot.swiftUIImage
        case .gloves: return DesignSystemAsset.Assets.stickerGloves.swiftUIImage
        case .cardigan: return DesignSystemAsset.Assets.itemDrawCardiganFront.swiftUIImage
        case .branch: return DesignSystemAsset.Assets.stickerBranch.swiftUIImage
        case .earMuff: return DesignSystemAsset.Assets.stickerEarMuff.swiftUIImage
        case .airPodMax1: return DesignSystemAsset.Assets.stickerAirPodMax1.swiftUIImage
        case .airPodMax2: return DesignSystemAsset.Assets.stickerAirPodMax2.swiftUIImage
        case .airPodMax3: return DesignSystemAsset.Assets.stickerAirPodMax3.swiftUIImage
        case .muffler1: return DesignSystemAsset.Assets.stickerMuffler1.swiftUIImage
        case .muffler2: return DesignSystemAsset.Assets.stickerMuffler2.swiftUIImage
        case .boots: return DesignSystemAsset.Assets.itemDrawBoots.swiftUIImage
        case .bikini: return DesignSystemAsset.Assets.stickerBikini.swiftUIImage
        case .can: return DesignSystemAsset.Assets.stickerCan.swiftUIImage
        case .santaHat: return DesignSystemAsset.Assets.stickerSantaHat.swiftUIImage
        case .sunglass: return DesignSystemAsset.Assets.stickerSunglass.swiftUIImage
        }
    }
}
