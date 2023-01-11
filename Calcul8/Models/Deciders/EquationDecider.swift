//
//  EquationDecider.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 24/04/2022.
//

import Foundation
import SwiftUI

struct EquationDecider : View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @AppStorage("twoVarSimulEqn") var twoVarSimulEqn: Bool = false
    @AppStorage("threeVarSimulEqn") var threeVarSimulEqn: Bool = false
    @AppStorage("quadraticSection") var quadraticSection: Bool = false
    
    var body: some View {
        if !twoVarSimulEqn && ( !threeVarSimulEqn && !quadraticSection) {
            EquationDeciderView()
        }
        else {
            if twoVarSimulEqn {
                withAnimation{
                    TwoVariableSimultaneousEquationView(solveColor: $standardOperator, textfieldBackground: $standardButton)
                }
            }
            else if threeVarSimulEqn {
                withAnimation{
                    ThreeVariableSimultaneousEquationView(solveColor: $standardOperator, textfieldBackground: $standardButton)
                }
            }
            else if quadraticSection {
                withAnimation {
                    QuadraticEquationView()
                }
            }
        }
    }
}
