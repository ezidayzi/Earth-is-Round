import CoreMotion

import ComposableArchitecture

// MARK: - PedometerClient

public struct PedometerClient {
    public let startFetchingSteps: () -> AsyncThrowingStream<Int, Error>
}

// MARK: DependencyKey

extension PedometerClient: DependencyKey {}

public extension DependencyValues {
    var pedometerClient: PedometerClient {
        get { self[PedometerClient.self] }
        set { self[PedometerClient.self] = newValue }
    }
}
