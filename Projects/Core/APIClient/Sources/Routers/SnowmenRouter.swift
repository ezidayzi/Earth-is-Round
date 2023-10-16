//
//  SnowmenRouter.swift
//  APIClient_ios
//
//  Created by 김윤서 on 2023/10/13.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

import Shared_ios

enum SnowmenRouter {
    case calculate(snowmen: [WeeklySnowmenSizeInfo])
}

extension SnowmenRouter: BaseRouter {
    var path: String {
        switch self {
        case .calculate:
            return "/snowmen"
        }
    }

    var params: [String : Any] {
        var params: [String: Any] = [:]
        switch self {
        case let .calculate(snowmen):
            params["calculatingList"] = snowmen.toDict()
        }
        return params
    }

    var query: [String : String?] {
        return [:]
    }

    var method: HttpMethod {
        return .POST
    }
}
