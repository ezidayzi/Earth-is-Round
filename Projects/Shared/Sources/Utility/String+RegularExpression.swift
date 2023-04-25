//
//  RegularExpression+.swift
//  Shared
//
//  Created by Junho Lee on 2023/04/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public extension String {
    func isEnglishAndNumber(range: ClosedRange<Int>) -> Bool {
        let pattern = "^[A-Za-z0-9]{\(range.lowerBound),\(range.upperBound)}$"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)

        return regex?.firstMatch(in: self, options: [], range: range) != nil
    }
    
    func isEnglish(range: ClosedRange<Int>) -> Bool {
        let pattern = "^[A-Za-z]{\(range.lowerBound),\(range.upperBound)}$"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)

        return regex?.firstMatch(in: self, options: [], range: range) != nil
    }
}
