//
//  BaseResponse.swift
//  APIClient
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

public struct BaseResponse<T: Decodable>: Decodable {
    public let response: T?
    public let errorCode: ErrorCode?
}

public enum ErrorCode: String, Decodable {
    case duplicateNickname = "DUPLICATE_NICKNAME"
    case accessDeny = "ACCESS_DENY"
    case unauthorized = "UNAUTHORIZED"
    case expireToken = "EXPIRE_TOKEN"
    case invalidToken = "INVALID_TOKEN"
    case invalidRequest = "INVALID_REQUEST"
    case unexpectedServerError = "UNEXPECTED_SERVER_ERROR"
    case invalidNickname = "INVALID_NICKNAME"
    case invalidPassword = "INVALID_PASSWORD"
    case notExistUser = "NOT_EXIST_USER"
    case notMatchPassword = "NOT_MATCH_PASSWORD"

    var description: String {
        switch self {
        case .duplicateNickname:
            return "중복된 nickname"
        case .accessDeny:
            return "권한 부족으로 인한 접근 불가"
        case .unauthorized:
            return "비인가 (인증이 아직 되지 않음)"
        case .expireToken:
            return "토큰 만료"
        case .invalidToken:
            return "유효하지 않은 토큰"
        case .invalidRequest:
            return "유효하지 않은 요청"
        case .unexpectedServerError:
            return "예상치 못한 서버 에러"
        case .invalidNickname:
            return "유효하지 않은 nickname"
        case .invalidPassword:
            return "유효하지 않은 password"
        case .notExistUser:
            return "존재하지 않는 유저"
        case .notMatchPassword:
            return "비밀번호 불일치"
        }
    }
}
