//
//  SnowmenAPI.swift
//  APIClient
//
//  Created by 김윤서 on 2023/09/30.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import Shared_watchOS
#endif


import ComposableArchitecture


// MARK: - UserAPI

public struct SnowmenAPI {
    public let calculate: (_ calculatingList:  [WeeklySnowmenSizeInfo]) async -> Result<Bool, Error>
}

// MARK: DependencyKey

extension SnowmenAPI: DependencyKey {}

public extension DependencyValues {
    var snowmenAPI: SnowmenAPI {
        get { self[SnowmenAPI.self] }
        set { self[SnowmenAPI.self] = newValue }
    }
}

extension SnowmenAPI: Serviceable {
    public static let liveValue: Self = {
        return .init { calculatingList in
            await performRequest(SnowmenRouter.calculate(snowmen: calculatingList))
        }
    }()
}
