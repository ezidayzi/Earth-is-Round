//
//  SnowmanItemType.swift
//  Shared_ios
//
//  Created by 김윤서 on 2023/07/31.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

public enum SnowmanItemType: Int, Decodable {
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

    // Priority 200
    case boots

    // Priority None
    case bikini
    case can
    case santaHat
    case sunglass
}
