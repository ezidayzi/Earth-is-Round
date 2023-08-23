//
//  StepAPI.swift
//  APIClient
//
//  Created by 김윤서 on 2023/08/21.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import Shared_watchOS
#endif

import ComposableArchitecture

// MARK: - UserAPI

public struct StepAPI {
    public let uploadSteps: (_ steps: [Step]) async -> Result<SnowmanItemListResponse, Error>
}

// MARK: DependencyKey

extension StepAPI: DependencyKey {}

public extension DependencyValues {
    var stepAPI: StepAPI {
        get { self[StepAPI.self] }
        set { self[StepAPI.self] = newValue }
    }
}

extension StepAPI: Serviceable {
    public static let liveValue: Self = {
        return .init { steps in
            await performRequest(StepRouter.uploadSteps(steps: steps))
        }
    }()
}
