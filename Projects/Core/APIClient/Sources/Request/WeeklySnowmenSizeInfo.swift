//
//  WeeklySnowmenSizeInfo.swift
//  APIClient_ios
//
//  Created by 김윤서 on 2023/10/13.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

public struct WeeklySnowmenSizeInfo: Encodable {
    public let calculateDate: String
    public let headSize: Int
    public let bodySize: Int

    public init(calculateDate: String, headSize: Int, bodySize: Int) {
        self.calculateDate = calculateDate
        self.headSize = headSize
        self.bodySize = bodySize
    }

    public init(calculateDate: String, stepsFromMondayToThursday: Int, stepsFromFridayToSunday: Int) {
        self.calculateDate = calculateDate
        if stepsFromMondayToThursday <= 3000 {
            self.headSize = 1
        } else {
            self.headSize = 2
        }
        if stepsFromFridayToSunday <= 3000 {
            self.bodySize = 1
        } else {
            self.bodySize = 2
        }
    }
}
