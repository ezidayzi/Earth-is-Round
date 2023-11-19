//
//  PushNotificationType.swift
//  PushNotificationClient
//
//  Created by 김윤서 on 2023/11/04.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation

public enum PushNotificationType: CaseIterable {
    case threeDays
    case sixDays
    case sundayNight
    case nextMorning
    case twoWeeks
    case threeWeeks

    var identifier: String {
        switch self {
        case .threeDays:
            return "threeDaysNotification"
        case .sixDays:
            return "sixDaysNotification"
        case .sundayNight:
            return "sundayNightNotification"
        case .nextMorning:
            return "nextMorningNotification"
        case .twoWeeks:
            return "twoWeeksNotification"
        case .threeWeeks:
            return "threeWeekNotification"
        }
    }

    var title: String {
        switch self {
        case .threeDays:
            return "from.눈사람"
        case .sixDays:
            return "from.눈사람"
        case .sundayNight:
            return "두둥~"
        case .nextMorning:
            return "from.눈사람"
        case .twoWeeks:
            return ""
        case .threeWeeks:
            return "안녕.."
        }
    }

    var content: String {
        switch self {
        case .threeDays:
            return [
                "자는구나..",
                "자니..?",
                "뭐해? 심심하다ㅋ"
            ].randomElement() ?? "자니..?"
        case .sixDays:
            return [
                "나한테 관심 좀 ㅠㅠ",
                "언제 볼거여",
                "이젠 내가 뭘 입던 관심없나 봄?ㅎ"
            ].randomElement() ?? "언제 볼거여"
        case .sundayNight:
            return [
                "마, 나님 등장!^^",
                "눈사람 등장~!",
                "반갑구만 반가워요~"
            ].randomElement() ?? "눈사람 등장~!"
        case .nextMorning:
            return [
                "나.. 안 볼 거니..?ㅋ",
                "제가 궁금하지 않으세요? ㅠㅠ",
                "당신과 얘기하고프구만",
                "아직도 기다리는 중~"
            ].randomElement() ?? "나.. 안 볼 거니..?ㅋ"
        case .twoWeeks:
            return [
                "일주일 안에 안 오면 우린 다 녹아버리겠지..",
                "나를 만들 마지막 기회임"
            ].randomElement() ?? "일주일 안에 안 오면 우린 다 녹아버리겠지.."
        case .threeWeeks:
            return "다음에는 좀 더 오랫동안 우리 눈사람을 만들어주길.."
        }
    }
}
