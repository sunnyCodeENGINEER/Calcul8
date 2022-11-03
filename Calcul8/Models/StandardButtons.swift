//
//  StandardButtons.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 18/04/2022.
//

import Foundation
import SwiftUI

enum StandardButtons: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case addition = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "×"
    case decimal = "."
    case clear = "AC"
    case backspace = "DEL"
    case negative = "-/+"
    case equal = "="
    
    var standardButtonsColor: Color {
        switch self {
        case .addition, .multiply, .divide, .equal, .subtract :
            return Color("standardOperator")
        case .clear, .negative, .backspace :
            return Color(.lightGray)
        default:
            return Color("standardButton")
        }
    }

}

//func setStandardColor(button: StandardButtons) -> Color {
//    switch StandardButtons {
//    case .addition, .multiply, .divide, .equal, .subtract :
//        return Color("standardOperator")
//    case .clear, .negative, .backspace :
//        return Color(.lightGray)
//    default:
//        return Color("standardButton")
//    }
//}
