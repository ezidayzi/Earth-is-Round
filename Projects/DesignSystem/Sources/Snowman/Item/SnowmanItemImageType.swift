//
//  SnowmanItemType.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/11.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

public enum SnowmanItemImageType {
    // Priority 1 : Eye, Mouth
    case button
    case stones
    case saw
    
    // Priority 10 : Nose
    case carrot
    case radish
    
    // Priority 50
    case gloves
    case cardiganFront, cardiganBack
    case branchLeft, branchRight
    
    case earMuffFront, earMuffBack
    case airPodMax1Front, airPodMax1Back
    case airPodMax2Front, airPodMax2Back
    case airPodMax3Front, airPodMax3Back
    
    // Priority 70
    case muffler1
    case muffler2
    
    // Priority 200
    case boots
    
    // Priority None
    case bikini
    case can
    case santaHat
    case sunglass
}
