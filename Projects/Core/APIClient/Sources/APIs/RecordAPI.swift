//
//  RecordAPI.swift
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

public struct RecordAPI {
    public let getList: (_ maxDate: String) async -> Result<SnowmanRecordListResponse, Error>
    public let getDetail: (_ startDate: String) async -> Result<SnowmanRecordDetailResponse, Error>
}

// MARK: DependencyKey

extension RecordAPI: DependencyKey {}

public extension DependencyValues {
    var recordAPI: RecordAPI {
        get { self[RecordAPI.self] }
        set { self[RecordAPI.self] = newValue }
    }
}

extension RecordAPI: Serviceable {
    public static let liveValue: Self = {
        return .init { maxDate in
            await performRequest(RecordRouter.getSnowmanRecordList(maxDate: maxDate))
        } getDetail: { startDate in
            await performRequest(RecordRouter.getSnowmanRecordDetail(startDate: startDate))
        }
    }()
}
