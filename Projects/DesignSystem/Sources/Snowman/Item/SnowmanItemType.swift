//
//  SnowmanItemType.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/11.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

public enum SnowmanItemType: Int {
    // Priority 1 : Eye, Mouth
    case button
    case stones
    case saw
    
    // Priority 10 : Nose
    case carrot
    case radish
    
    // Priority 50
    case gloves
    case cardigan
    case branch
    
    case earMuff
    case airPodMax1
    case airPodMax2
    case airPodMax3
    
    // Priority 70
    case muffler1
    case muffler2
    
    // Priority None
    case bikini
    case can
    case santaHat
    case sunglass
}
