import Foundation
import CoreMotion

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import Shared_watchOS
#endif

public extension PedometerClient {
    static let liveValue: Self = {
        var pedometer = CMPedometer()
        return .init(
            startFetchingSteps: {
                return AsyncThrowingStream<Int, Error> { continuation in
                    guard CMPedometer.isStepCountingAvailable() else {
                        continuation.finish(throwing: NSError(domain: "pedometer", code: 1))
                        return
                    }
                    pedometer.startUpdates(from: .todayStart) { data, error in
                        guard let steps = data?.numberOfSteps else {
                            continuation.finish(throwing: NSError(domain: "pedometer", code: 1))
                            return
                        }
                        continuation.yield(Int(truncating: steps))
                    }
                }
            }
        )
    }()
}
