//
//  View+paddings.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/04/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

#if os(iOS)
import Shared_ios
#else
import Shared_watchos
#endif

public extension View {
    func horizontalPadding(_ length: CGFloat = 24.adjusted) -> some View {
        padding(.horizontal, length)
    }
}
