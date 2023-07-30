import Foundation
import CoreLocation

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import Shared_watchOS
#endif

/// - NOTE(230730) @Duno
/// authorizationStatus에 따라 적절한 action 분기 필요
public extension LocationClient {
    static var manager = CLLocationManager()
    
    static let liveValue: Self = {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return .init(
            requestAuthorization: {
                manager.requestWhenInUseAuthorization()
            },
            getCurrentSpeed: {
                manager.startUpdatingLocation()
                return AsyncStream { continuation in
                    let delegate = LocationManagerDelegate(continuation: continuation)
                    manager.delegate = delegate
                    continuation.onTermination = { [delegate] _ in
                        _ = delegate
                    }
                }
            }
        )
    }()
    
    private class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
        public let continuation: AsyncStream<Double>.Continuation
        
        public init(
            continuation: AsyncStream<Double>.Continuation
        ) {
            self.continuation = continuation
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            updateCurrentSpeed(speed: location.speed)
        }
        
        private func updateCurrentSpeed(speed: Double) {
            let correctedSpeed = speed >= 0 ? speed : 0
            continuation.yield(correctedSpeed)
        }
    }
}
