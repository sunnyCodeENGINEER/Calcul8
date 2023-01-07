//
//  SpericalCoordinateVector.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 24/12/2022.
//

import Foundation

struct SphericalCoordinateSystem {
    
    var xComponent: SphericalCoordinateComponent = SphericalCoordinateComponent()
    var yComponent: SphericalCoordinateComponent = SphericalCoordinateComponent()
    var zComponent: SphericalCoordinateComponent = SphericalCoordinateComponent()
}
struct SphericalComponent: Identifiable {
    let id = UUID()
    var trigID: String = ""
    var component: [CartesianTerms] = []
    
    func getBases() -> String {
        var bases: String = trigID
        component.forEach { term in
            bases += term.getBases()
        }
        return bases
    }
    
    func getExponents() -> String {
        var exponents: String = ""
        component.forEach { term in
            exponents += term.getExponents()
        }
        return exponents
    }
}

struct SphericalTerms: Identifiable {
    var id = UUID()
    var trigCoefficient: [CartesianTerms] = []
    var component: [SphericalComponent] = []
    
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
        
        component.forEach { comp in
            bases.append(comp.trigID)
            comp.component.forEach { term in
                bases.append(term.getBases())
            }
        }

        return bases
    }

    func getComponentExponents() -> String {
        var exponents: String = ""
        component.forEach { comp in
            comp.component.forEach { term in
                exponents.append(term.getExponents())
            }
        }

        return exponents
    }
    
    func getComponentPersonality() -> String {
        var personality: String = ""
        personality.append(getCoefficientBases())
        personality.append(getCoefficientExponents())
//        personality.append(trigID)
        personality.append(getComponentBases())
        personality.append(getComponentExponents())
        
        return personality
    }
}

struct SphericalCoordinateComponent {
    var component: [SphericalTerms] = []
    
    subscript(index: Int) -> SphericalTerms {
        get {
            return component[index]
        }
        set {
            component[index] = newValue
        }
    }
    
}
