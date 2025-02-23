//
//  KeychainClient.swift
//  Shared_ios
//
//  Created by 김윤서 on 2023/08/18.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public struct KeychainClient {
    enum ServiceKey: String {
        case token = "token"
        case nickname = "nickname"
        case password = "password"
    }

    @KeychainValue(key: ServiceKey.token.rawValue)
    public static var token: String?

    @KeychainValue(key: ServiceKey.nickname.rawValue)
    public static var nickname: String?

    @KeychainValue(key: ServiceKey.password.rawValue)
    public static var password: String?

    public static func deleteAll() {
        KeychainClient.token = nil
        KeychainClient.nickname = nil
        KeychainClient.password = nil
    }
}
