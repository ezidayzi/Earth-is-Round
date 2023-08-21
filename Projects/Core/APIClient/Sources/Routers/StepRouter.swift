//
//  StepRouter.swift
//  APIClient
//
//  Created by 김윤서 on 2023/08/21.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public struct Step {
    let date: String
    let count: Int
}

enum StepRouter {
    case uploadSteps(steps: [Step])
}

extension StepRouter: BaseRouter {
    var path: String {
        switch self {
        case .uploadSteps:
            return "/steps"
        }
    }

    var params: [String : Any] {
        var params: [String: Any] = [:]
        switch self {
        case let .uploadSteps(steps):
            params["steps"] = steps
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

