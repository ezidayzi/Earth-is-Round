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
