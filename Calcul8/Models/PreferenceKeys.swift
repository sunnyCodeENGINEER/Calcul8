//
//  PreferenceKeys.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 16/01/2023.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
