//
//  SnowmanItemType.swift
//  Shared_ios
//
//  Created by 김윤서 on 2023/07/31.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

public enum SnowmanItemType: String, Codable {
    // Priority 1 : Eye, Mouth
    case button = "button"
    case stones = "stones"
    case saw = "saw"

    // Priority 10 : Nose
    case carrot = "carrot"
    case radish = "radish"

    // Priority 50
    case gloves = "gloves"
    case cardigan = "cardigan"
    case branch = "branch"

    case earMuff = "earMuff"
    case airPodMax1 = "airPodMax1"
    case airPodMax2 = "airPodMax2"
    case airPodMax3 = "airPodMax3"

    // Priority 70
    case muffler1 = "muffler1"
    case muffler2 = "muffler2"

    // Priority 200
    case boots = "boots"

    // Priority None
    case bikini = "bikini"
    case can = "can"
    case santaHat = "santaHat"
    case sunglass = "sunglass"

    public init(priority: Int) {
          switch priority {
          case 0: self = .button
          case 1: self = .stones
          case 2: self = .saw
          case 3: self = .carrot
          case 4: self = .radish
          case 5: self = .gloves
          case 6: self = .cardigan
          case 7: self = .branch
          case 8: self = .earMuff
          case 9: self = .airPodMax1
          case 10: self = .airPodMax2
          case 11: self = .airPodMax3
          case 12: self = .muffler1
          case 13: self = .muffler2
          case 14: self = .boots
          case 15: self = .bikini
          case 16: self = .can
          case 17: self = .santaHat
          case 18: self = .sunglass
          default:
              print("정의되어 있지 않은 priority 입니다.")
              self = .button
          }
    }

    public var priority: Int {
        switch self {
        case .button: return 0
        case .stones: return 1
        case .saw: return 2
        case .carrot: return 3
        case .radish: return 4
        case .gloves: return 5
        case .cardigan: return 6
        case .branch: return 7
        case .earMuff: return 8
        case .airPodMax1: return 9
        case .airPodMax2: return 10
        case .airPodMax3: return 11
        case .muffler1: return 12
        case .muffler2: return 13
        case .boots: return 14
        case .bikini: return 15
        case .can: return 16
        case .santaHat: return 17
        case .sunglass: return 18
        }
    }
}
