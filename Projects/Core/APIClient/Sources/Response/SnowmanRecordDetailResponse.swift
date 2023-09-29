//
//  SnowmanRecordDetailResponse.swift
//  APIClient
//
//  Created by 김윤서 on 2023/09/30.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public struct SnowmanRecordDetailResponse: Decodable {
    public let snowman: SnowmanRecordResponse
    public let steps: [Int]
    public let items: [SnowmanItemInfoResponse]
}
