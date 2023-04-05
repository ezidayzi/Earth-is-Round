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
