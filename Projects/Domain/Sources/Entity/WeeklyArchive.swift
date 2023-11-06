//
//  WeeklyArchive.swift
//  Domain_ios
//
//  Created by 김윤서 on 2023/07/31.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

import Shared_ios

public struct WeeklyArchive {
    public let uuid: UUID
    public let week: Int
    public let snowmanType: SnowmanType
    public let snowmanItemTypes: [SnowmanItemType]
    public let startDate: String

    public init(
        uuid: UUID,
        week: Int,
        snowmanType: SnowmanType,
        snowmanItemTypes: [SnowmanItemType],
        startDate: String
    ) {
        self.uuid = uuid
        self.week = week
        self.snowmanType = snowmanType
        self.snowmanItemTypes = snowmanItemTypes
        self.startDate = startDate
    }
}

extension WeeklyArchive: Equatable, Hashable {
    public static func == (lhs: WeeklyArchive, rhs: WeeklyArchive) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

extension WeeklyArchive: Comparable {
    public static func < (lhs: WeeklyArchive, rhs: WeeklyArchive) -> Bool {
        return lhs.week < rhs.week
    }
}

