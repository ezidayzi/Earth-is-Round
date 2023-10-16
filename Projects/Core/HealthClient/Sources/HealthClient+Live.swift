import Foundation
import HealthKit

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import Shared_watchOS
#endif

public extension HealthClient {
    static let liveValue: Self = {
        let healthStore = HKHealthStore()
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        
        return .init {
            let typesToShare: Set<HKSampleType> = [stepCountType]
            let typesToRead: Set<HKObjectType> = [stepCountType]

            return try await healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead)
        } getStepsFromMonday: {
            let calendar = Calendar.current
            
            guard
                let today = Date().today,
                let monday = Date().yesterday?.monday
            else { return [] }

            let predicate = HKQuery.predicateForSamples(
                withStart: monday,
                end: today,
                options: .strictStartDate
            )
            let query = HKStatisticsCollectionQuery(
                quantityType: stepCountType,
                quantitySamplePredicate: predicate,
                options: [.cumulativeSum],
                anchorDate: monday,
                intervalComponents: DateComponents(day: 1)
            )
            
            return try await withCheckedThrowingContinuation { continuation in
                query.initialResultsHandler = { query, results, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let results = results {
                        let steps = results.statistics().map {
                            $0.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0.0
                        }
                        continuation.resume(returning: steps.map { Int($0) })
                    } else {
                        continuation.resume(returning: [])
                    }
                }
                healthStore.execute(query)
            }
        } getStepsByPeriod: { start, end in
            let predicate = HKQuery.predicateForSamples(
                withStart: start,
                end: end,
                options: .strictStartDate
            )
            let query = HKStatisticsCollectionQuery(
                quantityType: stepCountType,
                quantitySamplePredicate: predicate,
                options: [.cumulativeSum],
                anchorDate: start,
                intervalComponents: DateComponents(day: 1)
            )
            return try await withCheckedThrowingContinuation { continuation in
                var stepsByDate: [Date: Int] = [:]

                query.initialResultsHandler = { query, results, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let results = results {
                        results.enumerateStatistics(from: start, to: end) { statistics, stop in

                            if let sumQuantity = statistics.sumQuantity() {
                                let steps = Int(sumQuantity.doubleValue(for: HKUnit.count()))
                                stepsByDate[statistics.startDate] = steps
                            }
                        }

                        continuation.resume(returning: stepsByDate)
                    } else {
                        continuation.resume(returning: [:])
                    }
                }
                healthStore.execute(query)
            }
        } getTotalStepsByPeriod: { start, end in
            let predicate = HKQuery.predicateForSamples(
                withStart: start,
                end: end,
                options: .strictStartDate
            )
            let query = HKStatisticsCollectionQuery(
                quantityType: stepCountType,
                quantitySamplePredicate: predicate,
                options: [.cumulativeSum],
                anchorDate: start,
                intervalComponents: DateComponents(day: 1)
            )
            return try await withCheckedThrowingContinuation { continuation in
                var sum = 0
                query.initialResultsHandler = { query, results, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let results = results {
                        results.enumerateStatistics(from: start, to: end) { statistics, stop in
                            if let sumQuantity = statistics.sumQuantity() {
                                let steps = Int(sumQuantity.doubleValue(for: HKUnit.count()))
                                sum += steps
                            }
                        }
                        continuation.resume(returning: sum)
                    } else {
                        continuation.resume(returning: 0)
                    }
                }
                healthStore.execute(query)
            }
        }
    }()
}
