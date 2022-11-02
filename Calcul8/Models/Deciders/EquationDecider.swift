//
//  EquationDecider.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 24/04/2022.
//

import Foundation
import SwiftUI

struct EquationDecider : View {
    //    @State var twoVarSimulEqn: Bool = false
    //    @State var threeVarSimulEqn: Bool = false
    
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
                    TwoVariableSimultaneousEquationView()
                }
            }
            else if threeVarSimulEqn {
                withAnimation{
                    ThreeVariableSimultaneousEquationView()
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
