//
//  PolarForm.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 26/04/2022.
//

import Foundation
import SwiftUI

struct PolarForm {
    var magnitude: Double = 0
    var realPart: Double = 0
    var imaginaryPart: Double = 0
}

func multiplyPolarForm(number1: PolarForm, number2: PolarForm) -> (magnitude: Double, realPart: Double, imaginaryPart: Double) {
    var resultMagnitude: Double {
        number1.magnitude * number2.magnitude
    }
    
    var resultRealPart: Double {
        number1.realPart + number2.realPart
    }
    
    var resultImaginarypart: Double {
        number1.imaginaryPart + number2.imaginaryPart
    }
    
    return (resultMagnitude, resultRealPart, resultImaginarypart)
}

func dividePolarForm(number1: PolarForm, number2: PolarForm) -> (magnitude: Double, realPart: Double, imaginaryPart: Double) {
    var resultMagnitude: Double {
        number1.magnitude / number2.magnitude
    }
    
    var resultRealPart: Double {
        number1.realPart - number2.realPart
    }
    
    var resultImaginarypart: Double {
        number1.imaginaryPart - number2.imaginaryPart
    }
    
    return (resultMagnitude, resultRealPart, resultImaginarypart)
}

func convertToComplexForm(number: PolarForm) -> (realPart: Double, imaginaryPart: Double) {
    var realPart: Double {
        return (number.magnitude * cos(number.realPart))
    }
    
    var imaginaryPart: Double {
        return (number.magnitude * sin(number.imaginaryPart))
    }
    
    return (realPart, imaginaryPart)
}

func radiansToDegrees(angle: Double) -> Double {
    return (angle * 180) / .pi
}

func degreesToRadians(angle: Double) -> Double {
    return (angle * .pi) / 180
}

func checkUnit(unit: Unit, number: PolarForm) -> (realPart: Double, imaginaryPart: Double) {
    var realPart: Double {
        switch unit {
        case .radians:
            return number.realPart
        case .piRadians:
            return (number.realPart / .pi)
            
        case .degrees:
            return radiansToDegrees(angle: number.realPart)
        }
    }
    
    var imaginaryPart: Double {
        switch unit {
        case .radians:
            return number.imaginaryPart
        case .piRadians:
            return (number.imaginaryPart / .pi)
            
        case .degrees:
            return radiansToDegrees(angle: number.imaginaryPart)
        }
    }
    
    
//    switch unit {
//    case .radians:
//        break
//    case .piRadians:
//        let realPart = (number.realPart / .pi)
//        let imaginaryPart = (number.imaginaryPart / .pi)
//
//        return (realPart, imaginaryPart)
//    case .degrees:
//        let realPart = (number.realPart / .pi)
//        let imaginaryPart = (number.imaginaryPart / .pi)
//
//        return (realPart, imaginaryPart)
//    }
    
    return (realPart, imaginaryPart)
}

func checkPolarFormOperation(operation: PolarFormOperation, number1: PolarForm, number2: PolarForm) -> (magnitude: Double, realPart: Double, imaginaryPart: Double) {
    var magnitude: Double = 0
    var realPart: Double = 0
    var imaginaryPart: Double = 0
    
    switch operation {
//    case .addition:
//        realPart = addComplexNumbers(number1: number1, number2: number2).realPart
//        imaginaryPart = addComplexNumbers(number1: number1, number2: number2).imaginaryPart
//    case .subtraction:
//        realPart = subtractComplexNumbers(number1: number1, number2: number2).realPart
//        imaginaryPart = subtractComplexNumbers(number1: number1, number2: number2).imaginaryPart
    case .multiplication:
        magnitude = multiplyPolarForm(number1: number1, number2: number2).magnitude
        realPart = multiplyPolarForm(number1: number1, number2: number2).realPart
        imaginaryPart = multiplyPolarForm(number1: number1, number2: number2).imaginaryPart
    case .division:
        magnitude = dividePolarForm(number1: number1, number2: number2).magnitude
        realPart = dividePolarForm(number1: number1, number2: number2).realPart
        imaginaryPart = dividePolarForm(number1: number1, number2: number2).imaginaryPart
    case .convertToComplexForm, .none:
        break
    }

    return (magnitude, realPart, imaginaryPart)
}
