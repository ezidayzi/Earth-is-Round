//
//  String+Localized.swift
//  Shared_ios
//
//  Created by Junho Lee on 2023/04/05.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: .module, comment: "")
    }
    
    func localized(with arguments: [CVarArg] = []) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
