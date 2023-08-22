//
//  Array+.swift
//  Shared_ios
//
//  Created by Junho Lee on 2023/04/05.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

public extension Array {
    func safeget(index: Int) -> Element? {
        return index >= 0 && index < count
        ? self[index]
        : nil
    }
}

extension Array where Element: Encodable {
    public func toDict() -> [[String: Any]] {
        return self.compactMap { element in
            do {
                let jsonData = try JSONEncoder().encode(element)
                if let dict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    return dict
                }
            } catch {
                print("Error converting object to dictionary: \(error)")
            }
            return nil
        }
    }
}
