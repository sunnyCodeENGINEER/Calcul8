//
//  SectionPickerView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 20/04/2022.
//

import SwiftUI

struct SectionPickerView: View {
//    @State var basicSection: Bool = true
//    @State var quadraticSection: Bool = false
//    @State var simultaneousSection: Bool = false
    
    @AppStorage("basicSection") var basicSection: Bool = true
    @AppStorage("quadraticSection") var quadraticSection: Bool = false
    @AppStorage("simultaneousSection") var simultaneousSection: Bool = false
    @AppStorage("complexNumberOperation") var complexNumberOperation: Bool = false
    @AppStorage("equationsection") var equationSection: Bool = false
    
    @AppStorage("twoVarSimulEqn") var twoVarSimulEqn: Bool = false
    @AppStorage("threeVarSimulEqn") var threeVarSimulEqn: Bool = false
    @AppStorage("complexNumber") var complexNumber: Bool = false
    @AppStorage("polarForm") var polarForm: Bool = false

    var label1: String = "Basic Functions"
    var label2: String = "Equation"
    var label3: String = "Advanced Calculations"
    
    var body: some View {
        VStack {
            if !basicSection {
                Button{
                    withAnimation{
                        basicSection = true
                        equationSection = false
                        complexNumberOperation = false
                        twoVarSimulEqn = false
                        threeVarSimulEqn = false
                        complexNumber = false
                        polarForm = false
                        quadraticSection = false
                    }
                } label: {
                    sectionButton(buttonLabel: label1)
                }
            }
            
            if !equationSection {
                Button{
                    withAnimation{
                        basicSection = false
                        equationSection = true
                        complexNumberOperation = false
                        twoVarSimulEqn = false
                        threeVarSimulEqn = false
                        complexNumber = false
                        polarForm = false
                        quadraticSection = false
                    }
                } label: {
                    sectionButton(buttonLabel: label2)
                }
            }
            
            if !complexNumberOperation {
                Button{
                    withAnimation{
                        basicSection = false
                        equationSection = false
                        complexNumberOperation = true
                        twoVarSimulEqn = false
                        threeVarSimulEqn = false
                        complexNumber = false
                        polarForm = false
                        quadraticSection = false
                    }
                } label: {
                    sectionButton(buttonLabel: label3)
                }
            }
        }
    }
}

struct SectionPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SectionPickerView()
    }
}

struct sectionButton: View {
    var buttonLabel: String = ""
    
    var body: some View {
        HStack{
            Text(buttonLabel)
                .foregroundColor(Color("solve"))
                .padding()
                .frame(width: buttonWidthAdvanced(), height: buttonHeighttAdvanced())
                .background(RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("standardOperator")))
        }
    }
    
    func buttonHeighttAdvanced() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

    
    func buttonWidthAdvanced() -> CGFloat {
        return (UIScreen.main.bounds.width * 0.7)
    }

}
