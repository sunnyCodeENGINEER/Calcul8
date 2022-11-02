//
//  ComplexNumber.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 26/04/2022.
//

import Foundation
import SwiftUI

struct ComplexNumber {
    var realPart: Double = 0
    var imaginaryPart: Double = 0
    
    
    }

func addComplexNumbers(number1: ComplexNumber, number2: ComplexNumber) -> (realPart: Double, imaginaryPart: Double) {
    var resultRealPart: Double {
        return number1.realPart + number2.realPart
    }
    
    var resultimaginaryPart: Double {
        return number1.imaginaryPart + number2.imaginaryPart
    }
    
    return (resultRealPart, resultimaginaryPart)
}

func subtractComplexNumbers(number1: ComplexNumber, number2: ComplexNumber) -> (realPart: Double, imaginaryPart: Double) {
    var resultRealPart: Double {
        return number1.realPart - number2.realPart
    }
    
    var resultimaginaryPart: Double {
        return number1.imaginaryPart - number2.imaginaryPart
    }
    
    return (resultRealPart, resultimaginaryPart)
}

func multiplyComplexNumbers(number1: ComplexNumber, number2: ComplexNumber) -> (realPart: Double, imaginaryPart: Double) {
    var resultRealPart: Double {
        return (number1.realPart * number2.realPart) - (number1.imaginaryPart * number2.imaginaryPart)
    }
    
    var resultimaginaryPart: Double {
        return (number1.imaginaryPart * number2.realPart) + (number1.realPart * number2.imaginaryPart)
    }
    
    return (resultRealPart, resultimaginaryPart)
}

func divideComplexNumbers(number1: ComplexNumber, number2: ComplexNumber) -> (realPart: Double, imaginaryPart: Double) {
    var resultRealPart: Double {
        return ((number1.realPart * number2.realPart) + (number1.imaginaryPart * number2.imaginaryPart)) / (( number2.realPart * number2.realPart) + (number2.imaginaryPart * number2.imaginaryPart))
    }
    
    var resultimaginaryPart: Double {
        return ((number1.imaginaryPart * number2.realPart) - (number1.realPart * number2.imaginaryPart)) / (( number2.realPart * number2.realPart) + (number2.imaginaryPart * number2.imaginaryPart))
    }
    
    return (resultRealPart, resultimaginaryPart)
}

func convertToPolarform(number: ComplexNumber) -> (magnitude: Double, realPart: Double, imaginaryPart: Double) {
    var magnitude: Double {
        return sqrt((number.realPart * number.realPart) + (number.imaginaryPart * number.imaginaryPart))
    }
    
    var realPart: Double {
        atan(number.imaginaryPart / number.realPart)
    }
    
    var imaginaryPart: Double {
        atan(number.imaginaryPart / number.realPart)
    }
    
    return (magnitude, realPart, imaginaryPart)
}

func checkComplexNumberOperation(operation: ComplexNumberOperation, number1: ComplexNumber, number2: ComplexNumber) -> (realPart: Double, imaginaryPart: Double) {
    var realPart: Double = 0
    var imaginaryPart: Double = 0
    
    switch operation {
    case .addition:
        realPart = addComplexNumbers(number1: number1, number2: number2).realPart
        imaginaryPart = addComplexNumbers(number1: number1, number2: number2).imaginaryPart
    case .subtraction:
        realPart = subtractComplexNumbers(number1: number1, number2: number2).realPart
        imaginaryPart = subtractComplexNumbers(number1: number1, number2: number2).imaginaryPart
    case .multiplication:
        realPart = multiplyComplexNumbers(number1: number1, number2: number2).realPart
        imaginaryPart = multiplyComplexNumbers(number1: number1, number2: number2).imaginaryPart
    case .division:
        realPart = divideComplexNumbers(number1: number1, number2: number2).realPart
        imaginaryPart = divideComplexNumbers(number1: number1, number2: number2).imaginaryPart
    case .convertToPolarForm:
//        realPart = convertToPolarform(number: number1).realPart
//        imaginaryPart = addComplexNumbers(number1: number1, number2: number2).imaginaryPart
        break
    case .convertToComplexForm, .none:
        break
    }
    
    return (realPart, imaginaryPart)
}
