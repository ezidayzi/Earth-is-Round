//
//  SnowmanItemInfo.swift
//  LocalStorageClient_ios
//
//  Created by 김윤서 on 2023/09/23.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//
import Shared_ios
import Foundation

public struct SnowmanItemInfo: Codable {
    public let date: String
    public var itemPoint: [ItemPoint]

    public init(date: String, itemPoint: [ItemPoint]) {
        self.date = date
        self.itemPoint = itemPoint
    }
}

public struct ItemPoint: Codable, Identifiable {
    public let id: String
    public let itemType: SnowmanItemType
    public var x: CGFloat
    public var y: CGFloat

    public init(itemType: SnowmanItemType, x: Double, y: Double) {
        self.id = UUID().uuidString
        self.itemType = itemType
        self.x = x
        self.y = y
    }
}

extension ItemPoint: Equatable, Hashable {
    public static func == (lhs: ItemPoint, rhs: ItemPoint) -> Bool {
        return lhs.itemType == rhs.itemType &&
        lhs.x == rhs.x &&
        lhs.y == rhs.y
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(itemType)
        hasher.combine(x)
        hasher.combine(y)
    }
}
