//
//  RectNavView.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 10/11/2022.
//

import SwiftUI

struct RectNavView: View {
    @State var coordinteSystem: CoordinateSystems = .rectangular
    @Binding var operation: VectorOperation
    @State var vector1XCoefficient: String = ""
    @State var vector1YCoefficient: String = ""
    @State var vector1ZCoefficient: String = ""
    
    @State var vector2XCoefficient: String = ""
    @State var vector2YCoefficient: String = ""
    @State var vector2ZCoefficient: String = ""
    
    @State var vector1XComp: [Variable] = []
    @State var vector1YComp: [Variable] = []
    @State var vector1ZComp: [Variable] = []
    
    @State var vector2XComp: [Variable] = []
    @State var vector2YComp: [Variable] = []
    @State var vector2ZComp: [Variable] = []
    
    @State var vector1XSign: Sign = .positive
    @State var vector1YSign: Sign = .positive
    @State var vector1ZSign: Sign = .positive
    
    @State var vector2XSign: Sign = .positive
    @State var vector2YSign: Sign = .positive
    @State var vector2ZSign: Sign = .positive
    
    @State var toFill: ToFill = .none
    
    @State var nav: Bool = false
    
    var body: some View {
        if nav {
            if toFill == .xComp {
                RectVector(component: $vector1XComp, component2: $vector2XComp, coefficient: $vector1XCoefficient, coefficient2: $vector2XCoefficient, sign: $vector1XSign, sign2: $vector2XSign, nav: $nav)
            } else if toFill == .yComp {
                RectVector(component: $vector1YComp, component2: $vector2YComp, coefficient: $vector1YCoefficient, coefficient2: $vector2YCoefficient, sign: $vector1YSign, sign2: $vector2YSign, nav: $nav)
            } else if toFill == .zComp {
                RectVector(component: $vector1ZComp, component2: $vector2ZComp, coefficient: $vector1ZCoefficient, coefficient2: $vector2ZCoefficient, sign: $vector1ZSign, sign2: $vector2ZSign, nav: $nav)
            }
        } else {
            RectVectorView(operation: $operation, vector1XCoefficient: $vector1XCoefficient, vector1YCoefficient: $vector1YCoefficient, vector1ZCoefficient: $vector1ZCoefficient, vector2XCoefficient: $vector2XCoefficient, vector2YCoefficient: $vector2YCoefficient, vector2ZCoefficient: $vector2ZCoefficient, vector1XComp: $vector1XComp, vector1YComp: $vector1YComp, vector1ZComp: $vector1ZComp, vector2XComp: $vector2XComp, vector2YComp: $vector2YComp, vector2ZComp: $vector2ZComp, vector1XSign: $vector1XSign, vector1YSign: $vector1YSign, vector1ZSign: $vector1ZSign, vector2XSign: $vector2XSign, vector2YSign: $vector2YSign, vector2ZSign: $vector2ZSign, nav: $nav, toFill: $toFill)
        }
    }
}

struct RectNavView_Previews: PreviewProvider {
    static var previews: some View {
        RectNavView(operation: .constant(.curl))
    }
}
