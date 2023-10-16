//
//  RecordRouter.swift
//  APIClient
//
//  Created by 김윤서 on 2023/09/30.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

import Shared_ios

enum RecordRouter {
    case getSnowmanRecordList(maxDate: String)
    case getSnowmanRecordDetail(startDate: String)
}

extension RecordRouter: BaseRouter {
    var path: String {
        switch self {
        case .getSnowmanRecordList:
            return "/records/list"
        case .getSnowmanRecordDetail:
            return "/records"
        }
    }

    var params: [String : Any] {
        return [:]
    }

    var query: [String : String?] {
        switch self {
        case .getSnowmanRecordList(let maxDate):
            return ["maxDate": maxDate]
        case .getSnowmanRecordDetail(let startDate):
            return ["startDate": startDate]
        }
    }

    var method: HttpMethod {
        return .GET
    }
}
