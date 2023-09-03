//
//  AuthAPI.swift
//  APIClient
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import Shared_watchOS
#endif

import ComposableArchitecture

// MARK: - UserAPI

public struct UserAPI {
    public let signUp: (_ nickname: String, _ password: String) async -> Result<Bool, Error>
    public let login: (_ nickname: String, _ password: String) async -> Result<LoginResponse, Error>
    public let updateNickname: (_ nickname: String) async -> Result<Bool, Error>
    public let updatePassword: (_ password: String) async -> Result<Bool, Error>
}

// MARK: DependencyKey

extension UserAPI: DependencyKey {}

public extension DependencyValues {
    var userAPI: UserAPI {
        get { self[UserAPI.self] }
        set { self[UserAPI.self] = newValue }
    }
}

extension UserAPI: Serviceable {
    public static let liveValue: Self = {
        return .init { nickname, password in
            await performRequest(UserRouter.signUp(nickname: nickname, password: password))
        } login: { nickname, password in
            await performRequest(UserRouter.login(nickname: nickname, password: password))
        } updateNickname: { nickname in
            await performRequest(UserRouter.updateNickname(nickname: nickname))
        } updatePassword: { password in
            await performRequest(UserRouter.updatePassword(password: password))
        }
    }()
}
