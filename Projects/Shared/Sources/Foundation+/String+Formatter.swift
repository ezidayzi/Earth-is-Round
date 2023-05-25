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
}

public extension Int {
    var decimal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
