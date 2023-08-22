import Foundation

import ComposableArchitecture
// MARK: - HealthClient

public struct HealthClient {
    public let requestAuthorization: () async throws -> Void
    public let getStepsFromMonday: () async throws -> [Int]
    public let getStepsByPeriod: (_ start: Date, _ end: Date) async throws -> [Date: Int]
}

// MARK: DependencyKey

extension HealthClient: DependencyKey {}

public extension DependencyValues {
    var healthClient: HealthClient {
        get { self[HealthClient.self] }
        set { self[HealthClient.self] = newValue }
    }
}
