import Foundation
import UserNotifications

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import Shared_watchOS
#endif

public extension PushNotificationClient {

    static let liveValue: Self = {
        return .init(
            requestAuthorization: {
                let center = UNUserNotificationCenter.current()
                let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
                return granted
            },
            requestNotificationsScheduling :{

                let threeDaysFromNow = Calendar.current.date(
                    byAdding: .day,
                    value: 3,
                    to: Date()
                )!
                var dateComponents = Calendar.current.dateComponents(
                    [.year, .month, .day, .hour, .minute, .second],
                    from: threeDaysFromNow
                )
                let result1 = await scheduleNotification(
                    type: PushNotificationType.threeDays,
                    dateComponents: dateComponents
                )



                let sixDaysFromNow = Calendar.current.date(
                    byAdding: .day,
                    value: 6,
                    to: Date()
                )!
                dateComponents = Calendar.current.dateComponents(
                    [.year, .month, .day, .hour, .minute, .second],
                    from: sixDaysFromNow
                )
                let result2 = await scheduleNotification(
                    type: PushNotificationType.sixDays,
                    dateComponents: dateComponents
                )



                dateComponents = DateComponents()
                dateComponents.weekday = 2
                dateComponents.hour = 0
                let result3 = await scheduleNotification(
                    type: PushNotificationType.sundayNight,
                    dateComponents: dateComponents
                )



                dateComponents = DateComponents(hour: 9)
                let result4 = await scheduleNotification(
                    type: PushNotificationType.nextMorning,
                    dateComponents: dateComponents
                )



                let twoWeeksFromNow = Calendar.current.date(
                    byAdding: .day,
                    value: 14,
                    to: Date()
                )!
                dateComponents = Calendar.current.dateComponents(
                    [.year, .month, .day, .hour, .minute, .second],
                    from: twoWeeksFromNow
                )
                let result5 = await scheduleNotification(
                    type: PushNotificationType.twoWeeks,
                    dateComponents: dateComponents
                )



                let threeWeeksFromNow = Calendar.current.date(
                    byAdding: .day,
                    value: 21,
                    to: Date()
                )!
                dateComponents = Calendar.current.dateComponents(
                    [.year, .month, .day, .hour, .minute, .second],
                    from: threeWeeksFromNow
                )
                let result6 = await scheduleNotification(
                    type: PushNotificationType.threeWeeks,
                    dateComponents: dateComponents
                )


                let results: [Bool] = [result1, result2, result3, result4, result5, result6]

                return results.contains { !$0 }
                ? .failure(PushNotificationError.schedulingFailed)
                : .success(())
            },
            cancelNotificationsScheduling : { types in
                let identifiers = types.map { $0.identifier }
                let center = UNUserNotificationCenter.current()
                center.removePendingNotificationRequests(withIdentifiers: identifiers)
            }
        )
    }()

    static private func scheduleNotification(
        type: PushNotificationType,
        dateComponents: DateComponents
    ) async -> Bool {
        let content = UNMutableNotificationContent()
        content.title = type.title
        content.body = type.content

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: type.identifier,
            content: content,
            trigger: trigger
        )

        let center = UNUserNotificationCenter.current()
        do {
            try await center.add(request)
            print("[\(type.identifier)] 알림 스케줄링 성공")
            return true
        } catch {
            print("\(type.identifier) 알림 스케줄링 실패: \(error)")
            return false
        }
    }
}
