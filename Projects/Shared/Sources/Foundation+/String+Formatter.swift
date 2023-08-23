//
//  String+Formatter.swift
//  Shared
//
//  Created by Junho Lee on 2023/05/25.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public extension String {
    var decimal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: Double(self) ?? 0)) ?? ""
    }

    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .autoupdatingCurrent
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}

public extension Int {
    var decimal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
