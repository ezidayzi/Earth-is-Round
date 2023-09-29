//
//  SnowmanType.swift
//  Shared_ios
//
//  Created by 김윤서 on 2023/07/31.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

public enum SnowmanType {
    case largeHeadLargeBody
    case largeHeadSmallBody
    case smallHeadLargeBody
    case smallHeadSmallBody

    public init(headSize: Int, bodySize: Int) {
        switch (headSize, bodySize) {
        case (2..., 2...):
            self = .largeHeadLargeBody
        case (2..., _):
            self = .largeHeadSmallBody
        case (_, 2...):
            self = .smallHeadLargeBody
        default:
            self = .smallHeadSmallBody
        }
    }
}
