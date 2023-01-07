//
//  CylindricalCoordinateVector.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 23/12/2022.
//

import Foundation

protocol Vector {
    var xComponent: CartesianCoordinateComponent { get set }
    var yComponent: CartesianCoordinateComponent { get set }
    var zComponent: CartesianCoordinateComponent { get set }
}

//struct CylindricalCoordinateSystem: Vector {
//
//    var xComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
//    var yComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
//    var zComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
//}

struct CylindricalCoordinateSystem {
    
    var xComponent: CylindricalCoordinateComponent = CylindricalCoordinateComponent()
    var yComponent: CylindricalCoordinateComponent = CylindricalCoordinateComponent()
    var zComponent: CylindricalCoordinateComponent = CylindricalCoordinateComponent()
}

struct CylindricalTerms: Identifiable {
    var id = UUID()
    var trigID: String = ""
    var trigCoefficient: [CartesianTerms] = []
    var component: [CartesianTerms] = []
    
    func getCoefficientBases() -> String {
        var bases: String = ""
        trigCoefficient.forEach { term in
            bases.append(term.getBases())
        }
        
        return bases
    }
    
    func getCoefficientExponents() -> String {
        var exponents: String = ""
        trigCoefficient.forEach { term in
            exponents.append(term.getExponents())
        }
        
        return exponents
    }
    
    func getComponentBases() -> String {
        var bases: String = ""
        component.forEach { term in
            bases.append(term.getBases())
        }
        
        return bases
    }
    
    func getComponentExponents() -> String {
        var exponents: String = ""
        component.forEach { term in
            exponents.append(term.getExponents())
        }
        
        return exponents
    }
    
    func getComponentPersonality() -> String {
        var personality: String = ""
        personality.append(getCoefficientBases())
        personality.append(getCoefficientExponents())
        personality.append(trigID)
        personality.append(getComponentBases())
        personality.append(getComponentExponents())
        
        return personality
    }
}

struct CylindricalTermssss: Identifiable {
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

struct AngleComponent {
    var theta: Double = 0
}

struct CylindricalCoordinateComponent {
    var component: [CylindricalTerms] = []
    
    subscript(index: Int) -> CylindricalTerms {
        get {
            return component[index]
        }
        set {
            component[index] = newValue
        }
    }
    
}
