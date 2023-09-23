//
//  SnowmanItemListResponse.swift
//  APIClient
//
//  Created by 김윤서 on 2023/08/21.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Shared_ios
import Foundation

public struct SnowmanItemListResponse: Decodable {
    public let items: [SnowmanItemInfo]
}

public struct SnowmanItemInfo: Decodable {
    public let getDate: String
    public let name: SnowmanItemType
}
