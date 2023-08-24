//
//  AuthRouter.swift
//  APIClient
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

enum UserRouter {
    case signUp(nickname: String, password: String)
    case login(nickname: String, password: String)
    case updateNickname(nickname: String)
}

extension UserRouter: BaseRouter {
    var path: String {
        switch self {
        case .signUp:
            return "/users/signup"
        case .login:
            return "/users/login"
        case .updateNickname:
            return "/users"
        }
    }
    
    var params: [String : Any] {
        var params: [String: Any] = [:]
        switch self {
        case .signUp(let nickname, let password),
                .login(let nickname, let password):
            params["nickname"] = nickname
            params["password"] = password
        default:
            break
        }
        return params
    }
    
    var query: [String : String?] {
        switch self {
        case let .updateNickname(nickname):
            return ["nickname": nickname]
        default:
            return [:]
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .login, .signUp:
            return .POST
        case .updateNickname:
            return .PATCH
        }
    }
}

