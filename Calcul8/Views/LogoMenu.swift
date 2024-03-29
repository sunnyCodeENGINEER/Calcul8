//
//  LogoMenu.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 02/11/2022.
//

import SwiftUI

struct LogoMenu: View {
    @AppStorage("basicSection") var basicSection: Bool = true
    @AppStorage("quadraticSection") var quadraticSection: Bool = false
    @AppStorage("simultaneousSection") var simultaneousSection: Bool = false
    @AppStorage("complexNumberOperation") var complexNumberOperation: Bool = false
    @AppStorage("equationsection") var equationSection: Bool = false
    
    @AppStorage("twoVarSimulEqn") var twoVarSimulEqn: Bool = false
    @AppStorage("threeVarSimulEqn") var threeVarSimulEqn: Bool = false
    @AppStorage("complexNumber") var complexNumber: Bool = false
    @AppStorage("polarForm") var polarForm: Bool = false
    
    @AppStorage("appLogo") var appLogo: String = "appLogo"
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    
    @Binding var animateLogo: Bool
    @Binding var showMenu: Bool
    @Binding var menuOpacity: Bool
    @Binding var width: CGFloat
    
    var body: some View {
        ZStack {
            if showMenu {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.ultraThickMaterial)
                    .blur(radius: 30)
                    .ignoresSafeArea()
                    .opacity(0.3)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.9)) {
                            setWidth()
                            showMenu = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                menuOpacity = false
                            }
                        }
                    }
            }
            
            HStack(alignment: showMenu ? .bottom : .top) {
                Spacer()
                
                VStack {
                    if showMenu {
                        Spacer()
                    }
                    
                    Button {
                        withAnimation(.easeOut(duration: 0.9)) {
                            setWidth()
                            showMenu.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                menuOpacity.toggle()
                            }
                        }
                    } label: {
                        Image(appLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: animateLogo ? width  * 0.7 : width * 0.5)
                            .animation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true), value: animateLogo)
                    }
                    if showMenu {
                        HStack {
                            Spacer()
                            
                            SectionPickerView()
                                .opacity(menuOpacity ? 1 : 0)
                                .animation(.easeOut(duration: 1.2), value: menuOpacity)
                                .padding()
                            
                            Spacer()
                        }
                    }
                        Spacer()
                    
                    if showMenu {
                        Button {
                            withAnimation{
                                basicSection = false
                                equationSection = false
                                complexNumberOperation = false
                                twoVarSimulEqn = false
                                threeVarSimulEqn = false
                                complexNumber = false
                                polarForm = false
                                quadraticSection = false
                            }
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(standardOperator))
                                .frame(width: UIScreen.main.bounds.width / 7)
                                .padding(.bottom, 40)
                        }
                        .opacity(menuOpacity ? 1 : 0)
                        .animation(.easeOut(duration: 1.2), value: menuOpacity)
                        .padding()
                    }
                }
                .padding(.trailing)
            }
            .onAppear {
                animateLogo = true
        }
        }
    }
    
    func setWidth() {
        if width == UIScreen.main.bounds.width / 8 {
            width = UIScreen.main.bounds.width / 2
        } else {
            width = UIScreen.main.bounds.width / 8
        }
    }
}
