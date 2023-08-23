//
//  Step.swift
//  Shared_ios
//
//  Created by 김윤서 on 2023/08/23.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public struct Step: Encodable {
    public init(date: String, count: Int) {
        self.date = date
        self.count = count
    }

    let date: String
    let count: Int
}
