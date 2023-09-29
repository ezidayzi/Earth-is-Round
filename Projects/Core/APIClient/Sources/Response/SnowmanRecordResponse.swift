//
//  SnowmanRecordResponse.swift
//  APIClient
//
//  Created by 김윤서 on 2023/09/30.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Shared_ios

public struct SnowmanRecordResponse: Decodable {
    public let headSize: Int
    public let bodySize: Int
    public let startDate: String
    public let endDate: String
    public let usedItems: [SnowmanItemType]
}
