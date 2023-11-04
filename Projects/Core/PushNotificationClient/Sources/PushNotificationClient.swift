import ComposableArchitecture

// MARK: - PedometerClient

public struct PushNotificationClient {
    public let requestNotificationsScheduling: () async -> Result<Void, Error>
}

// MARK: DependencyKey

extension PushNotificationClient: DependencyKey {}

public extension DependencyValues {
    var pushNotificationClient: PushNotificationClient {
        get { self[PushNotificationClient.self] }
        set { self[PushNotificationClient.self] = newValue }
    }
}

