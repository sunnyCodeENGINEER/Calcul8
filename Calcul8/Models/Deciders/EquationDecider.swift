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
            ZStack {
                AppBackgroundView()
                
                EquationDeciderView()
                    .respectSafeARea()
            }
        }
        else {
            if twoVarSimulEqn {
                withAnimation{
                    ZStack {
                        AppBackgroundView()
                        
                        TwoVariableSimultaneousEquationView(solveColor: $standardOperator, textfieldBackground: $standardButton)
                            .respectSafeARea()
                    }
                }
            }
            else if threeVarSimulEqn {
                withAnimation{
                    ZStack {
                        AppBackgroundView()
                        
                        ThreeVariableSimultaneousEquationView(solveColor: $standardOperator, textfieldBackground: $standardButton)
                            .respectSafeARea()
                    }
                }
            }
            else if quadraticSection {
                withAnimation {
                    ZStack {
                        AppBackgroundView()
                        
                        QuadraticEquationView()
                            .respectSafeARea()
                    }
                }
            }
        }
    }
}
