import ComposableArchitecture

// MARK: - PedometerClient

public struct PushNotificationClient {
    public let requestAuthorization: () async throws -> Bool
    public let requestNotificationsScheduling: () async -> Result<Void, Error>
    public let cancelNotificationsScheduling: (_ types: [PushNotificationType]) -> Void
}

// MARK: DependencyKey

extension PushNotificationClient: DependencyKey {}

public extension DependencyValues {
    var pushNotificationClient: PushNotificationClient {
        get { self[PushNotificationClient.self] }
        set { self[PushNotificationClient.self] = newValue }
    }
}

