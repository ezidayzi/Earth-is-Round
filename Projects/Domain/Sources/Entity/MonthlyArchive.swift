//
//  MonthlyArchive.swift
//  Domain_ios
//
//  Created by 김윤서 on 2023/07/31.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public struct MonthlyArchive {
    public let uuid: UUID
    public let month: Int
    public let weeklyArchive: [WeeklyArchive]

    public init(
        uuid: UUID,
        month: Int,
        weeklyArchive: [WeeklyArchive]
    ) {
        self.uuid = uuid
        self.month = month
        self.weeklyArchive = weeklyArchive
    }
}

extension MonthlyArchive: Equatable, Hashable {
    public static func == (lhs: MonthlyArchive, rhs: MonthlyArchive) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
