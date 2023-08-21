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
    let items: [SnowmanItemInfo]
}

public struct SnowmanItemInfo: Decodable {
    let getDate: String
    let name: SnowmanItemType
}
