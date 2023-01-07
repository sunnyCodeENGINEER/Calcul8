//
//  CartesianCoordinateVector.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 15/12/2022.
//

import Foundation
import SwiftUI

struct CartesianCoordinateSystem {
    var xComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
    var yComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
    var zComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
    
    func sortAxes() -> (CartesianCoordinateComponent, CartesianCoordinateComponent, CartesianCoordinateComponent) {
        let retornXComponent = sortComponent(component: xComponent)
        let retornYComponent = sortComponent(component: yComponent)
        let retornZComponent = sortComponent(component: zComponent)
        
        return (retornXComponent, retornYComponent, retornZComponent)
    }
    
    private func sortComponent(component: CartesianCoordinateComponent) -> CartesianCoordinateComponent {
        var toSetExpression: CartesianCoordinateComponent = CartesianCoordinateComponent()
        var express = component
        
        
        // algorithm used -> BUBBLE SORT
        // loop to access each array element
        for i in (0..<express.component.count) {
                // loop to compare array elements
            for j in (0..<((express.component.count) - (i + 1))) {
                    // compare two adjacent elements
                    // change > to < to sort in descending order
                if express.component[j].getBases() > express.component[j + 1].getBases() {
                    // swapping elements if elements are not in intended order
                    let temp = express.component[j]
                    express.component[j] = express.component[j + 1]
                    express.component[j + 1] = temp
                    
                }
                
                // swap elements according to their exponents
                if express.component[j].getBases() == express.component[j + 1].getBases() {
                    // swapping elements if elements are not in intended order
                    if express.component[j].getExponents() > express.component[j + 1].getExponents() {
                        // swapping elements if elements are not in intended order
                        let temp = express.component[j]
                        express.component[j] = express.component[j + 1]
                        express.component[j + 1] = temp
                        
                    }
                }
            }
            
            
            
            toSetExpression = express
        }
        
        return toSetExpression
    }
}

struct CartesianTerms: Identifiable {
    var id = UUID()
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


struct Variable: Identifiable {
    var id = UUID()
    @State var base: String = ""
    @State var exponent: String = ""
}
