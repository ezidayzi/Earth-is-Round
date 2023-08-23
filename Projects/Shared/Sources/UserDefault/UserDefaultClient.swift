//
//  UserDefaultClient.swift
//  Shared_ios
//
//  Created by 김윤서 on 2023/08/21.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

import ComposableArchitecture
import Dependencies

// MARK: - UserDefaultsClient
public struct UserDefaultsClient {
    public var boolForKey: (String) -> Bool
    public var dataForKey: (String) -> Data?
    public var doubleForKey: (String) -> Double
    public var integerForKey: (String) -> Int
    public var stringForKey: (String) -> String
    public var remove: (String) -> Void
    public var setBool: (Bool, String) -> Void
    public var setData: (Data?, String) -> Void
    public var setDouble: (Double, String) -> Void
    public var setInteger: (Int, String) -> Void
    public var setString: (String, String) -> Void
}


// MARK: DependencyKey

extension UserDefaultsClient: DependencyKey {}

public extension DependencyValues {
    var userDefaultsClient: UserDefaultsClient {
        get { self[UserDefaultsClient.self] }
        set { self[UserDefaultsClient.self] = newValue }
    }
}
