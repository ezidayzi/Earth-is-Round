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

public extension Date {
    var today: Self? {
        return Calendar.current.date(
            bySettingHour: 0,
            minute: 0,
            second: 0,
            of: self
        )
    }
    
    var monday: Self? {
        Calendar.current.date(
            byAdding: .day,
            value: -(self.weekday - 2),
            to: self.today ?? self
        )
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    // 일요일 - 1부터 시작
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    // 월요일 - 0부터 시작
    var weekdayFromMonday: Int {
        return weekday == 1
        ? weekday + 5
        : weekday - 2
    }
}
