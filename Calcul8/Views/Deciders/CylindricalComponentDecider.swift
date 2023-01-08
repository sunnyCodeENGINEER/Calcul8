//
//  CylindricalComponentDecider.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 23/12/2022.
//

import SwiftUI

struct CylindricalComponentSignDecider: View {
    @Binding var vector1: SphericalCoordinateSystem
    @Binding var vector2: SphericalCoordinateSystem
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var currentVector: Int
    @Binding var exponents: Bool
    @Binding var term: SphericalTerms
    @Binding var sphericalComponent: SphericalComponent
    
    var body: some View {
        VStack {
            if currentVector == 1 {
                if currentComponent == "r" {
                    SphericalSignSelector(axis: $vector1.xComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "theta" || currentComponent == "θ" {
                    SphericalSignSelector(axis: $vector1.yComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "z" {
                    SphericalSignSelector(axis: $vector1.zComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                }
            } else if currentVector == 2 {
                if currentComponent == "r" {
                    SphericalSignSelector(axis: $vector2.xComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "theta" || currentComponent == "θ" {
                    SphericalSignSelector(axis: $vector2.yComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "z" {
                    SphericalSignSelector(axis: $vector2.zComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                }
            }
        }
    }
}

struct CylindricalComponentSelectorDecider: View {
    @Binding var vector1: SphericalCoordinateSystem
    @Binding var vector2: SphericalCoordinateSystem
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var currentVector: Int
    @Binding var term: SphericalTerms
    @Binding var sphericalComponent: SphericalComponent
    
    var body: some View {
        VStack {
            if currentVector == 1 {
                if currentComponent == "r" {
                    CylindricalComponentSelectorRow(axis: $vector1.xComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                    
                } else if currentComponent == "theta" || currentComponent == "θ" {
                    CylindricalComponentSelectorRow(axis: $vector1.yComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "z" {
                    CylindricalComponentSelectorRow(axis: $vector1.zComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                }
            } else if currentVector == 2 {
                if currentComponent == "r" {
                    CylindricalComponentSelectorRow(axis: $vector2.xComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "theta" || currentComponent == "θ" {
                    CylindricalComponentSelectorRow(axis: $vector2.yComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "z" {
                    CylindricalComponentSelectorRow(axis: $vector2.zComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                }
            }
        }
    }
}

struct CylindricalComponentSelectorRow: View {
    @Binding var axis: SphericalCoordinateComponent
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var term: SphericalTerms
    @Binding var sphericalComponent: SphericalComponent
    
    var body: some View {
        HStack {
            SphericalComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "r", currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
            SphericalComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "θ", currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
            SphericalComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "z", currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
        }
    }
}

struct CylindricalKeyboardDecider: View {
    @Binding var vector1: SphericalCoordinateSystem
    @Binding var vector2: SphericalCoordinateSystem
    @Binding var components: [CartesianTerms]
    @Binding var exponents: Bool
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var trignometry: Bool
    @Binding var term: SphericalTerms
    @Binding var axis: SphericalCoordinateComponent
    @Binding var sphericalComponent: SphericalComponent
    @Binding var currentComponent: String
    @Binding var currentVector: Int
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    var body: some View {
        if currentVector == 1 {
            if currentComponent == "r" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector1.xComponent, sphericalComponent: $sphericalComponent, mySolveColor: $mySolveColor, myColor: $myColor)
            } else if currentComponent == "θ" || currentComponent == "theta" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector1.yComponent, sphericalComponent: $sphericalComponent, mySolveColor: $mySolveColor, myColor: $myColor)
            } else if currentComponent == "z" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector1.zComponent, sphericalComponent: $sphericalComponent, mySolveColor: $mySolveColor, myColor: $myColor)
            }
        } else if currentVector == 2 {
            if currentComponent == "r" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector2.xComponent, sphericalComponent: $sphericalComponent, mySolveColor: $mySolveColor, myColor: $myColor)
            } else if currentComponent == "θ" || currentComponent == "theta" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector2.yComponent, sphericalComponent: $sphericalComponent, mySolveColor: $mySolveColor, myColor: $myColor)
            } else if currentComponent == "z" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector2.zComponent, sphericalComponent: $sphericalComponent, mySolveColor: $mySolveColor, myColor: $myColor)
            }
        }
    }
}

struct CylindricalDoneButtonDecider: View {
    @Binding var vector: SphericalCoordinateSystem
    @Binding var term: SphericalTerms
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var sphericalComponent: SphericalComponent
    
    var body: some View {
        if currentComponent == "r" {
            HStack {
                SphericalClearAll(vector: $vector, term: $term, component: $component)
                SphericalClearButton(axis: $vector.xComponent, term: $term, component: $component)
                SphericalDoneButton(axis: $vector.xComponent, term: $term, component: $component, variable: $variable, currentComponent: $currentComponent, sphericalComponent: $sphericalComponent)
            }
        } else if currentComponent == "θ" || currentComponent == "θ" {
            HStack {
                SphericalClearAll(vector: $vector, term: $term, component: $component)
                SphericalClearButton(axis: $vector.yComponent, term: $term, component: $component)
                SphericalDoneButton(axis: $vector.yComponent, term: $term, component: $component, variable: $variable, currentComponent: $currentComponent, sphericalComponent: $sphericalComponent)
            }
        } else if currentComponent == "z" {
            HStack {
                SphericalClearAll(vector: $vector, term: $term, component: $component)
                SphericalClearButton(axis: $vector.zComponent, term: $term, component: $component)
                SphericalDoneButton(axis: $vector.zComponent, term: $term, component: $component, variable: $variable, currentComponent: $currentComponent, sphericalComponent: $sphericalComponent)
            }
        }
    }
}

//struct SphericalClearAll: View {
//    @Binding var vector: SphericalCoordinateSystem
//    @Binding var term: SphericalTerms
//    @Binding var component: CartesianTerms
//    
//    
//    var body: some View {
//        HStack {
//            Button {
//                vector.xComponent.component.removeAll()
//                vector.yComponent.component.removeAll()
//                vector.zComponent.component.removeAll()
//                term = SphericalTerms()
//                component = CartesianTerms()
//            } label: {
//                Text("Clear All")
//            }
//        }
//    }
//}
