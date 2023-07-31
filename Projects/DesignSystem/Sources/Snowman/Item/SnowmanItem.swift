//
//  SnowmanItem.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/11.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import Shared_ios

public struct SnowmanItem {
    
    enum AttachmentPoint {
        case head
        case body
    }
    
    let type: SnowmanItemType
    
    var images: [SnowmanItemImageType] {
        switch type {
            // Priority 1 : Eye, Mouth
        case .button: return [.button]
            
        case .stones: return [.stones]
        case .saw: return [.saw]
            
            // Priority 10 : Nose
        case .carrot: return [.carrot]
        case .radish: return [.radish]
            
            // Priority 50
        case .gloves: return [.gloves]
        case .cardigan: return [.cardiganFront, .cardiganBack]
        case .branch: return [.branchLeft, .branchRight]
            
        case .earMuff: return [.earMuffFront, .earMuffBack]
        case .airPodMax1: return [.airPodMax1Front, .airPodMax1Back]
        case .airPodMax2: return [.airPodMax2Front, .airPodMax2Back]
        case .airPodMax3: return [.airPodMax3Front, .airPodMax3Back]
            
            // Priority 70
        case .muffler1: return [.muffler1]
        case .muffler2: return [.muffler2]
            
            // Priority 200
        case .boots: return [.boots]
            
            // Priority None
        case .bikini: return [.bikini]
        case .can: return [.can]
        case .santaHat: return [.santaHat]
        case .sunglass: return [.sunglass]
        }
    }
    
    func getImages(by type: SnowmanType) -> [SnowmanItemImage] {
        return images.map { SnowmanItemImage(type: $0, snowmanType: type) }
    }
    
    var attachmentPoint: AttachmentPoint {
        switch type {
        case .button, .stones, .saw, .carrot, .radish, .can, .santaHat, .sunglass, .earMuff, .muffler1, .muffler2, .airPodMax1, .airPodMax2, .airPodMax3:
            return .head
        default: return .body
        }
    }
}
