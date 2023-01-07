//
//  SphericalComponentDecider.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 24/12/2022.
//

import SwiftUI


struct SphericalComponentSignDecider: View {
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
                if currentComponent == "R" {
                    SphericalSignSelector(axis: $vector1.xComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "Φ" || currentComponent == "ϕ" {
                    SphericalSignSelector(axis: $vector1.yComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "θ" {
                    SphericalSignSelector(axis: $vector1.zComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                }
            } else if currentVector == 2 {
                if currentComponent == "R" {
                    SphericalSignSelector(axis: $vector2.xComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "Φ" || currentComponent == "ϕ" {
                    SphericalSignSelector(axis: $vector2.yComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "θ" {
                    SphericalSignSelector(axis: $vector2.zComponent, term: $term, component: $component, variable: $variable, exponents: $exponents, sphericalComponent: $sphericalComponent)
                }
            }
        }
    }
}

struct SphericalComponentSelectorDecider: View {
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
                if currentComponent == "R" {
                    SphericalComponentSelectorRow(axis: $vector1.xComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                    
                } else if currentComponent == "Φ" || currentComponent == "ϕ" {
                    SphericalComponentSelectorRow(axis: $vector1.yComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "θ" {
                    SphericalComponentSelectorRow(axis: $vector1.zComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                }
            } else if currentVector == 2 {
                if currentComponent == "R" {
                    SphericalComponentSelectorRow(axis: $vector2.xComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "Φ" || currentComponent == "ϕ" {
                    SphericalComponentSelectorRow(axis: $vector2.yComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                } else if currentComponent == "θ" {
                    SphericalComponentSelectorRow(axis: $vector2.zComponent, component: $component, variable: $variable,currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
                }
            }
        }
    }
}

struct SphericalComponentSelectorRow: View {
    @Binding var axis: SphericalCoordinateComponent
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var term: SphericalTerms
    @Binding var sphericalComponent: SphericalComponent
    
    var body: some View {
        HStack {
            SphericalComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "R", currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
            SphericalComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "ϕ", currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
            SphericalComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "θ", currentComponent: $currentComponent, term: $term, sphericalComponent: $sphericalComponent)
        }
    }
}

struct SphericalKeyboardDecider: View {
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
    
    var body: some View {
        if currentVector == 1 {
            if currentComponent == "R" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector1.xComponent, sphericalComponent: $sphericalComponent)
            } else if currentComponent == "Φ" || currentComponent == "ϕ" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector1.yComponent, sphericalComponent: $sphericalComponent)
            } else if currentComponent == "θ" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector1.zComponent, sphericalComponent: $sphericalComponent)
            }
        } else if currentVector == 2 {
            if currentComponent == "R" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector2.xComponent, sphericalComponent: $sphericalComponent)
            } else if currentComponent == "Φ" || currentComponent == "ϕ" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector2.yComponent, sphericalComponent: $sphericalComponent)
            } else if currentComponent == "θ" {
                SphericalVariableKeyboard(components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector2.zComponent, sphericalComponent: $sphericalComponent)
            }
        }
    }
}

struct SphericalDoneButtonDecider: View {
    @Binding var vector: SphericalCoordinateSystem
    @Binding var term: SphericalTerms
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var sphericalComponent: SphericalComponent
    
    var body: some View {
        if currentComponent == "R" {
            HStack {
                SphericalClearAll(vector: $vector, term: $term, component: $component)
                SphericalClearButton(axis: $vector.xComponent, term: $term, component: $component)
                SphericalDoneButton(axis: $vector.xComponent, term: $term, component: $component, variable: $variable, currentComponent: $currentComponent, sphericalComponent: $sphericalComponent)
            }
        } else if currentComponent == "Φ" || currentComponent == "ϕ" {
            HStack {
                SphericalClearAll(vector: $vector, term: $term, component: $component)
                SphericalClearButton(axis: $vector.yComponent, term: $term, component: $component)
                SphericalDoneButton(axis: $vector.yComponent, term: $term, component: $component, variable: $variable, currentComponent: $currentComponent, sphericalComponent: $sphericalComponent)
            }
        } else if currentComponent == "θ" {
            HStack {
                SphericalClearAll(vector: $vector, term: $term, component: $component)
                SphericalClearButton(axis: $vector.zComponent, term: $term, component: $component)
                SphericalDoneButton(axis: $vector.zComponent, term: $term, component: $component, variable: $variable, currentComponent: $currentComponent, sphericalComponent: $sphericalComponent)
            }
        }
    }
}

struct SphericalClearAll: View {
    @Binding var vector: SphericalCoordinateSystem
    @Binding var term: SphericalTerms
    @Binding var component: CartesianTerms
    
    
    var body: some View {
        HStack {
            Button {
                vector.xComponent.component.removeAll()
                vector.yComponent.component.removeAll()
                vector.zComponent.component.removeAll()
                term = SphericalTerms()
                component = CartesianTerms()
            } label: {
                Text("Clear All")
            }
        }
    }
}

/*
struct SphericalComponentDecider: View {
    @Binding var vector1: SphericalCoordinateSystem
    @Binding var vector2: SphericalCoordinateSystem
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var currentVector: Int
    @Binding var exponents: Bool
    
    var body: some View {
        VStack {
            if currentVector == 1 {
                if currentComponent == "r" {
                    SignSelector(axis: $vector1.xComponent, component: $component, variable: $variable, exponents: $exponents)
                } else if currentComponent == "phi" {
                    SignSelector(axis: $vector1.yComponent, component: $component, variable: $variable, exponents: $exponents)
                } else if currentComponent == "theta" || currentComponent == "θ" {
                    SignSelector(axis: $vector1.zComponent, component: $component, variable: $variable, exponents: $exponents)
                }
            } else if currentVector == 2 {
                if currentComponent == "r" {
                    SignSelector(axis: $vector2.xComponent, component: $component, variable: $variable, exponents: $exponents)
                } else if currentComponent == "phi" {
                    SignSelector(axis: $vector2.yComponent, component: $component, variable: $variable, exponents: $exponents)
                } else if currentComponent == "theta" || currentComponent == "θ" {
                    SignSelector(axis: $vector2.zComponent, component: $component, variable: $variable, exponents: $exponents)
                }
            }
        }
    }
}

struct SphericalComponentSelectorRow: View {
    @Binding var axis: CartesianCoordinateComponent
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    
    var body: some View {
        HStack {
            ComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "r", currentComponent: $currentComponent)
            ComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "phi", currentComponent: $currentComponent)
            ComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "θ", currentComponent: $currentComponent)
        }
    }
}

struct SphericalComponentSelectorDecider: View {
    @Binding var vector1: SphericalCoordinateSystem
    @Binding var vector2: SphericalCoordinateSystem
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    @Binding var currentVector: Int
    
    var body: some View {
        VStack {
            if currentVector == 1 {
                if currentComponent == "r" {
                    SphericalComponentSelectorRow(axis: $vector1.xComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                    
                } else if currentComponent == "phi" {
                    SphericalComponentSelectorRow(axis: $vector1.yComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                } else if currentComponent == "theta" || currentComponent == "θ" {
                    SphericalComponentSelectorRow(axis: $vector1.zComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                }
            } else if currentVector == 2 {
                if currentComponent == "r" {
                    SphericalComponentSelectorRow(axis: $vector2.xComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                } else if currentComponent == "phi" {
                    SphericalComponentSelectorRow(axis: $vector2.yComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                } else if currentComponent == "theta" || currentComponent == "θ" {
                    SphericalComponentSelectorRow(axis: $vector2.zComponent, component: $component, variable: $variable,currentComponent: $currentComponent)
                }
            }
        }
    }
}

struct SphericalDoneButtonDecider: View {
    @Binding var vector: SphericalCoordinateSystem
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    
    var body: some View {
        if currentComponent == "r" {
            HStack {
                SphericalClearAll(vector: $vector)
                ClearButton(axis: $vector.xComponent)
                DoneButton(axis: $vector.xComponent, component: $component, variable: $variable, currentComponent: $currentComponent)
            }
        } else if currentComponent == "phi" {
            HStack {
                SphericalClearAll(vector: $vector)
                ClearButton(axis: $vector.yComponent)
                DoneButton(axis: $vector.yComponent, component: $component, variable: $variable, currentComponent: $currentComponent)
            }
        } else if currentComponent == "theta" || currentComponent == "θ" {
            HStack {
                SphericalClearAll(vector: $vector)
                ClearButton(axis: $vector.zComponent)
                DoneButton(axis: $vector.zComponent, component: $component, variable: $variable, currentComponent: $currentComponent)
            }
        }
    }
}

struct SphericalClearAll: View {
    @Binding var vector: SphericalCoordinateSystem
    
    
    var body: some View {
        HStack {
            Button {
                vector.xComponent.component.removeAll()
                vector.yComponent.component.removeAll()
                vector.zComponent.component.removeAll()
            } label: {
                Text("Clear All")
            }
        }
    }
}
*/
