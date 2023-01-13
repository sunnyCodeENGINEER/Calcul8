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
    
    @State private var animateLogo: Bool = false
    @State private var showMenu: Bool = false
    @State private var menuOpacity: Bool = false
    @State private var width: CGFloat = UIScreen.main.bounds.width / 8

    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Equations".uppercased())
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                    }.padding(.leading)
                    
                    Spacer()
                }.padding()
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
                                .foregroundColor(Color(standardOperator))
                                .blur(radius: 1))
                            .shadow(color: .black, radius: 10, x: -5, y: 5)
                        
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
                                .foregroundColor(Color(standardOperator))
                                .blur(radius: 1))
                            .shadow(color: .black, radius: 10, x: -5, y: 5)
                        
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
                                .foregroundColor(Color(standardOperator))
                                .blur(radius: 1))
                            .shadow(color: .black, radius: 10, x: -5, y: 5)
                    }
                    .padding(.bottom)
                }
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
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
