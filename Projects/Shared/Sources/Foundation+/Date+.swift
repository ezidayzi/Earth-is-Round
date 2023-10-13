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
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var yesterday: Self? {
        return Calendar.current.date(
            byAdding: .day,
            value: -1,
            to: startOfDay
        )
    }

    var today: Self? {
        return Calendar.current.date(
            bySettingHour: 0,
            minute: 0,
            second: 0,
            of: startOfDay
        )
    }
    
    var monday: Self? {
        Calendar.current.date(
            byAdding: .day,
            value: -(self.weekday - 2),
            to: self.today ?? self
        )
    }

    var lastSunday: Self? {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: self)
        let daysUntilLastSunday = (calendar.component(.weekday, from: today) + 7 - 1) % 7
        let lastSunday = calendar.date(byAdding: .day, value: -daysUntilLastSunday, to: today)
        return lastSunday
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

    // 월요일을 기준으로 주차 계산
    var weekNumberStartingOnMonday: Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        let day = calendar.component(.day, from: self)

        guard
            let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self)),
            let firstWeekdayOfMonth = calendar.dateComponents([.weekday], from: firstDayOfMonth).weekday
        else {
             return 0
        }
        let offset = (weekday - firstWeekdayOfMonth + 7) % 7
        let weekNumber = (day + offset - 1) / 7 + 1
        return weekNumber
    }

    enum DateFormatType: String {
        case standard = "yyyy-MM-dd HH:mm:ss"
        case yearMonthDay = "yyyy-MM-dd"
    }

    func toString(withFormat format: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = .autoupdatingCurrent
        return dateFormatter.string(from: self)
    }

    var dateOnly: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components) ?? self
    }
}
