//
//  APIError.swift
//  APIClient_ios
//
//  Created by 김윤서 on 2023/08/17.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public enum APIError: Error {

    case requestFailed
    case responseError(errorCode: ErrorCode)
    case decodingFailed(description: String)
    case invalidRequestError

    var customDescription: String {
        switch self {
        case .requestFailed:
            return "Request Failed error"
        case let .responseError(errorCode):
            return "Response Error: Status Code \(errorCode.description)"
        case let .decodingFailed(description):
            return "JSON Decoding Failed: \(description)"
        case .invalidRequestError:
            return "Invalid Request Error"
        }
    }
}
