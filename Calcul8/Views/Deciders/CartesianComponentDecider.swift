//
//  CartesianComponentDecider.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 16/12/2022.
//

import SwiftUI

struct CartesianComponentDecider: View {
    @Binding var vector1: CartesianCoordinateSystem
    @Binding var vector2: CartesianCoordinateSystem
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var currentVector: Int
    @Binding var exponents: Bool
    
    var body: some View {
        VStack {
            if currentVector == 1 {
                if currentComponent == "i" {
                    SignSelector(axis: $vector1.xComponent, component: $component, variable: $variable, exponents: $exponents)
                } else if currentComponent == "j" {
                    SignSelector(axis: $vector1.yComponent, component: $component, variable: $variable, exponents: $exponents)
                } else if currentComponent == "k" {
                    SignSelector(axis: $vector1.zComponent, component: $component, variable: $variable, exponents: $exponents)
                }
            } else if currentVector == 2 {
                if currentComponent == "i" {
                    SignSelector(axis: $vector2.xComponent, component: $component, variable: $variable, exponents: $exponents)
                } else if currentComponent == "j" {
                    SignSelector(axis: $vector2.yComponent, component: $component, variable: $variable, exponents: $exponents)
                } else if currentComponent == "k" {
                    SignSelector(axis: $vector2.zComponent, component: $component, variable: $variable, exponents: $exponents)
                }
            }
        }
    }
}

struct ComponentSelectorDecider: View {
    @Binding var vector1: CartesianCoordinateSystem
    @Binding var vector2: CartesianCoordinateSystem
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var currentVector: Int
    
    var body: some View {
        VStack {
            if currentVector == 1 {
                if currentComponent == "i" {
                    ComponentSelectorRow(axis: $vector1.xComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                    
                } else if currentComponent == "j" {
                    ComponentSelectorRow(axis: $vector1.yComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                } else if currentComponent == "k" {
                    ComponentSelectorRow(axis: $vector1.zComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                }
            } else if currentVector == 2 {
                if currentComponent == "i" {
                    ComponentSelectorRow(axis: $vector2.xComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                } else if currentComponent == "j" {
                    ComponentSelectorRow(axis: $vector2.yComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                } else if currentComponent == "k" {
                    ComponentSelectorRow(axis: $vector2.zComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                }
            }
        }
    }
}

struct DoneButtonDecider: View {
    @Binding var vector: CartesianCoordinateSystem
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    
    var body: some View {
        if currentComponent == "i" {
            HStack {
                ClearAll(vector: $vector)
                ClearButton(axis: $vector.xComponent)
                DoneButton(axis: $vector.xComponent, component: $component, variable: $variable, currentComponent: $currentComponent)
            }
        } else if currentComponent == "j" {
            HStack {
                ClearAll(vector: $vector)
                ClearButton(axis: $vector.yComponent)
                DoneButton(axis: $vector.yComponent, component: $component, variable: $variable, currentComponent: $currentComponent)
            }
        } else if currentComponent == "k" {
            HStack {
                ClearAll(vector: $vector)
                ClearButton(axis: $vector.zComponent)
                DoneButton(axis: $vector.zComponent, component: $component, variable: $variable, currentComponent: $currentComponent)
            }
        }
    }
}

//struct CartesianComponentDecider_Previews: PreviewProvider {
//    static var previews: some View {
//        CartesianComponentDecider()
//    }
//}
