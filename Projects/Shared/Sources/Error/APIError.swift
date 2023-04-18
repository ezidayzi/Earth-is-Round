//
//  APIError.swift
//  Shared_ios
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

public enum APIError: Error {

    case requestFailed
    case responseError(description: String)
    case decodingFailed(description: String)
    case invalidRequestError

    var customDescription: String {
        switch self {
        case .requestFailed:
            return "Request Failed error"
        case let .responseError(description):
            return "Response Error: Status Code \(description)"
        case let .decodingFailed(description):
            return "JSON Decoding Failed: \(description)"
        case .invalidRequestError:
            return "Invalid Request Error"
        }
    }
}

