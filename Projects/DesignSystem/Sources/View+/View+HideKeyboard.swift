//
//  View+HideKeyboard.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/04/25.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    public func onTapHideKeyboard() -> some View {
        contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
    }
}
#endif


