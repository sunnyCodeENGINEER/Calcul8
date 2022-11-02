//
//  AdvancedButtons.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 19/04/2022.
//

import Foundation
import SwiftUI

enum AdvancedButtons: String {
    case sine = "sin()"
    case cosine = "cos()"
    case tangent = "tan()"
    case cotangent = "cot()"
    case sec = "sec()"
    case cosec = "csc()"
    case squared = "x²"
    case powered = "x³"
    case sqrRoot = "√"
    case otherRoot = "∛"
    case logarithm = "ln()"
    case exponen = "exp()"
    
    var advancedButtonsColor: Color {
        switch self {
        case .sine, .cosine, .tangent, .cotangent, .sec, .cosec, .squared, .powered, .sqrRoot, .otherRoot, .logarithm, .exponen:
            return Color("standardButton")
        }
    }
}
