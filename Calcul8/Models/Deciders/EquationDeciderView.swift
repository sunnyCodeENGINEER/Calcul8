//
//  EquationDeciderView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 24/04/2022.
//

import SwiftUI

struct EquationDeciderView: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    
    @AppStorage("twoVarSimulEqn") var twoVarSimulEqn: Bool = false
    @AppStorage("threeVarSimulEqn") var threeVarSimulEqn: Bool = false
    @AppStorage("quadraticSection") var quadraticSection: Bool = false

    var body: some View {
        VStack {
            Button{
                withAnimation{
                    twoVarSimulEqn = false
                    threeVarSimulEqn = false
                    quadraticSection = true
                }
            } label: {
                Text("Solve Quadratic Equation")
                    .foregroundColor(Color("solve"))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20)
                        .frame(width: buttonWidth())
                        .foregroundColor(Color(standardOperator)))
                
            }
            .padding(.bottom)
            
            Button{
                withAnimation{
                    twoVarSimulEqn = true
                    threeVarSimulEqn = false
                    quadraticSection = false
                }
            } label: {
                Text("Simultaneous Equation with two variables")
                    .foregroundColor(Color("solve"))
                    .padding()
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .frame(width: buttonWidth())
                        .foregroundColor(Color(standardOperator)))
                
            }
            .padding(.bottom)
            
            Button{
                withAnimation{
                    twoVarSimulEqn = false
                    threeVarSimulEqn = true
                    quadraticSection = false
                }
            } label: {
                Text("Simultaneous Equation with three variables")
                    .foregroundColor(Color("solve"))
                    .padding()
                .padding(.horizontal)
                .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .frame(width: buttonWidth())
                        .foregroundColor(Color(standardOperator)))
            }
            .padding(.bottom)
        }
    }
    
    func buttonWidth() -> CGFloat {
        
        return (UIScreen.main.bounds.width) / 1.2
    }
}

struct EquationDeciderView_Previews: PreviewProvider {
    static var previews: some View {
        EquationDeciderView()
    }
}
