import Foundation

import ComposableArchitecture
// MARK: - LocalStorageClient

public struct LocalStorageClient {
    public let initSnowmanItems: (_ items: [SnowmanItemInfo]) async -> Result<Void, LocalStorageError>
    public let updateSnowmanItems: (_ items: [SnowmanItemInfo]) async -> Result<Void, LocalStorageError>
    public let getSnowmanItem: (_ date: String) async -> Result<SnowmanItemInfo, LocalStorageError>
}

// MARK: DependencyKey

extension LocalStorageClient: DependencyKey { }

public extension DependencyValues {
    var localStorageClient: LocalStorageClient {
        get { self[LocalStorageClient.self] }
        set { self[LocalStorageClient.self] = newValue }
    }
}

