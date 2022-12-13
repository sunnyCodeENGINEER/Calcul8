//
//  CartesianCoordinateComponent.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 12/12/2022.
//

import Foundation
import SwiftUI


struct CartesianTerms: Identifiable {
    let id = UUID()
    var coefficient: String = ""
    var terms: [Variable] = []
    
    subscript(number: Int) -> Variable {
        get {
            return terms[number]
        }
        set {
            terms[number] = newValue
        }
    }
    
    func getBases() -> String {
        var bases: String = ""
        
        terms.forEach { term in
            bases.append(term.base)
            
        }
        
        return bases
    }
    func getExponents() -> String {
        var exponents: String = ""
        
        terms.forEach { term in
            exponents.append(term.exponent)
            
        }
        
        return exponents
    }
}
struct CartesianCoordinateComponent {
    var component: [CartesianTerms] = []
    
    subscript(index: Int) -> CartesianTerms {
        get {
            return component[index]
        }
        set {
            component[index] = newValue
        }
    }
    
}
