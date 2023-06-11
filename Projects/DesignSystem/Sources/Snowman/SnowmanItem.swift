//
//  SnowmanItem.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/11.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

public struct SnowmanItem {
    let type: SnowmanItemType
    
    enum AttachmentPoint {
        case head
        case body
    }
    
    var width: CGFloat {
        switch type {
        case .hat:
            return 50
        case .scarf:
            return 60
        case .carrotNose:
            return 10
        }
    }
    
    var height: CGFloat {
        switch type {
        case .hat:
            return 20
        case .scarf:
            return 10
        case .carrotNose:
            return 5
        }
    }
    
    var positionFromCenter: CGPoint {
        switch type {
        case .hat:
            return CGPoint(x: 0, y: -30)
        case .scarf:
            return CGPoint(x: 0, y: 10)
        case .carrotNose:
            return CGPoint(x: 0, y: -5)
        }
    }
    
    var attachmentPoint: AttachmentPoint {
        switch type {
        case .hat, .carrotNose:
            return .head
        case .scarf:
            return .body
        }
    }
    
    var frontImage: Image {
        switch type {
        case .hat:
            return Image("hat_front")
        case .scarf:
            return Image("scarf_front")
        case .carrotNose:
            return Image("carrot_nose")
        }
    }
    
    var backImage: Image? {
        switch type {
        case .hat:
            return Image("hat_back")
        case .scarf, .carrotNose:
            return nil
        }
    }
}

