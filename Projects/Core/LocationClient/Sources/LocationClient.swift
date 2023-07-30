import ComposableArchitecture

// MARK: - LocationClient

public struct LocationClient {
    public let requestAuthorization: () async -> Void
    public let getCurrentSpeed: () -> AsyncStream<Double>
}

// MARK: DependencyKey

extension LocationClient: DependencyKey {}

public extension DependencyValues {
    var locationClient: LocationClient {
        get { self[LocationClient.self] }
        set { self[LocationClient.self] = newValue }
    }
}
