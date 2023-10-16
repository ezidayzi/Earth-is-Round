//
//  SnowmanRecordListResponse.swift
//  APIClient
//
//  Created by 김윤서 on 2023/09/30.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public struct SnowmanRecordListResponse: Decodable {
    public let total: Int
    public let snowmen: [SnowmanRecordResponse]
}
