import Foundation

import ComposableArchitecture
// MARK: - LocalStorageClient

public struct LocalStorageClient {
    public let appendSnowmanItemInfo: (_ items: [SnowmanItemInfo]) async -> Result<Void, LocalStorageError>
    public let updateSnowmanItemPoint: (_ date: String, _ items: ItemPoint) async -> Result<Void, LocalStorageError>
    public let getSnowmanItem: (_ date: String) async -> Result<SnowmanItemInfo, LocalStorageError>
    public let deleteAll: () -> Void
}

// MARK: DependencyKey

extension LocalStorageClient: DependencyKey { }

public extension DependencyValues {
    var localStorageClient: LocalStorageClient {
        get { self[LocalStorageClient.self] }
        set { self[LocalStorageClient.self] = newValue }
    }
}

