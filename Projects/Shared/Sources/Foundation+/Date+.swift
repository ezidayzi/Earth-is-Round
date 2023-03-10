//
//  Date+.swift
//  Shared_ios
//
//  Created by Junho Lee on 2023/03/10.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

public extension Date {
    static var todayStart: Self {
        return Calendar.current.date(
            bySettingHour: 0,
            minute: 0,
            second: 0,
            of: Date()
        )!
    }
}
