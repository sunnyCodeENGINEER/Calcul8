//
//  TwoVariableSimultaneousEquationView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 21/04/2022.
//

import SwiftUI
import simd

struct TwoVariableSimultaneousEquationView: View {
    @State var eqn1var1: String = ""
    @State var eqn1var2: String = ""
    @State var eqn1var3: String = ""
    @State var eqn2var1: String = ""
    @State var eqn2var2: String = ""
    @State var eqn2var3: String = ""
    
    @AppStorage("twoVarSimulEqn") var twoVarSimulEqn: Bool = false
    
    @FocusState var isFocused: Bool
    
    @State var showAnswers: Bool = false
    
    @State var animateLogo: Bool = false
    @State var showMenu: Bool = false
    @State var menuOpacity: Bool = false
    @State var width: CGFloat = UIScreen.main.bounds.width / 8
    
    //    var variableMatrix: [[Double]] = [
    //        [0.00, 0.00],
    //        [0.00, 0.00]
    //    ]
    
    @State var variableMatrix = simd_double2x2(rows: [
        simd_double2(0, 0),
        simd_double2(0, 0)
    ])
    
    @State var equalsMatrix = simd_double2(0, 0)
    
    @State var answerMatrix = simd_double2(0, 0)
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button{
                        withAnimation{
                            twoVarSimulEqn = false
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .padding(.leading)
                    
                    Spacer()
                }

                Spacer(minLength: 30)
                
                VStack{
                    Text("Input the values from the equations below.")
                        .padding(.vertical)
                        .padding(.top, 30)
                    
                    HStack {
                        Text("Equation1: ")
                        
                        TextField("0", text: $eqn1var1)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: QuadraticEquationView().textfieldWidth(), height: QuadraticEquationView().textfieldWidth())
                            .background(.gray.opacity(0.3))
                            .cornerRadius(15)
                            .focused($isFocused)
                            .keyboardType(.numberPad)
                        
                        Text("x + ")
                        
                        TextField("0", text: $eqn1var2)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: QuadraticEquationView().textfieldWidth(), height: QuadraticEquationView().textfieldWidth())
                            .background(.gray.opacity(0.3))
                            .cornerRadius(15)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        
                        Text("y = ")
                        
                        TextField("0", text: $eqn1var3)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: QuadraticEquationView().textfieldWidth(), height: QuadraticEquationView().textfieldWidth())
                            .background(.gray.opacity(0.3))
                            .cornerRadius(15)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        
                        
                    }
                    
                    HStack {
                        Text("Equation2: ")
                        
                        TextField("0", text: $eqn2var1)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: QuadraticEquationView().textfieldWidth(), height: QuadraticEquationView().textfieldWidth())
                            .background(.gray.opacity(0.3))
                            .cornerRadius(15)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text("x + ")
                        
                        TextField("0", text: $eqn2var2)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: QuadraticEquationView().textfieldWidth(), height: QuadraticEquationView().textfieldWidth())
                            .background(.gray.opacity(0.3))
                            .cornerRadius(15)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text("y = ")
                        
                        TextField("0", text: $eqn2var3)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: QuadraticEquationView().textfieldWidth(), height: QuadraticEquationView().textfieldWidth())
                            .background(.gray.opacity(0.3))
                            .cornerRadius(15)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        
                        
                    }
                    HStack {
                        
                        Spacer()
                        
                        Button{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation {
                                    getMatrices(eqn1var1: eqn1var1, eqn1var2: eqn1var2, eqn1var3: eqn1var3, eqn2var1: eqn2var1, eqn2var2: eqn2var2, eqn2var3: eqn2var3)
                                    
                                    showAnswers = true
                                    isFocused = false
                                }
                            }
                            
                        } label: {
                            Text("Solve")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("solve"))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color("standardOperator")))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 3)
                    
                    HStack{
                        Spacer()
                        
                        Text("Answers".uppercased())
                            .font(.title)
                        
                        Spacer()
                        
                    }
                    .frame(height: QuadraticEquationView().textfieldWidth())
                    .background(Color.gray.opacity(0.3))
                    
                    //            Text("x = \(answerMatrix.x) \ny = \(answerMatrix.y)")
                    if showAnswers {
                        Text(String(format: "x = %.4f \ny = %.4f", answerMatrix.x, answerMatrix.y))
                    }
                }
                Spacer()
                
//                SectionPickerView()
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
        }
    }
    
    func getMatrices(eqn1var1: String, eqn1var2: String, eqn1var3: String, eqn2var1: String, eqn2var2: String, eqn2var3: String) {
        variableMatrix = simd_double2x2(rows: [
            simd_double2((Double(eqn1var1) ?? 0), (Double(eqn1var2) ?? 0)),
            simd_double2((Double(eqn2var1) ?? 0), (Double(eqn2var2) ?? 0))
        ])
        
        equalsMatrix = simd_double2((Double(eqn1var3) ?? 0), (Double(eqn2var3) ?? 0))
        
        solveMatrices(variables: variableMatrix, equals: equalsMatrix)
    }
    
    func solveMatrices(variables: simd_double2x2, equals: simd_double2) {
        answerMatrix = simd_mul(variables.inverse, equals)
    }
}

struct TwoVariableSimultaneousEquationView_Previews: PreviewProvider {
    static var previews: some View {
        TwoVariableSimultaneousEquationView()
    }
}