//
//  LoginResponse.swift
//  APIClient
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

public struct LoginResponse: Codable {
    public let nickname, token: String
}
