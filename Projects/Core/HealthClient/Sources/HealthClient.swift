import ComposableArchitecture

// MARK: - HealthClient

public struct HealthClient {
    public let requestAuthorization: () async throws -> Void
    public let getStepsFromMonday: () async throws -> [Int]
}

// MARK: DependencyKey

extension HealthClient: DependencyKey {}

public extension DependencyValues {
    var healthClient: HealthClient {
        get { self[HealthClient.self] }
        set { self[HealthClient.self] = newValue }
    }
}
