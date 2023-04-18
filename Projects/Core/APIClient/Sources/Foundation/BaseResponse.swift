//
//  BaseResponse.swift
//  APIClient
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

public struct BaseResponse<T: Codable>: Codable {
    public let response: T?
}
