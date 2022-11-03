//
//  AdvancedCalculationDeciderView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 28/04/2022.
//

import SwiftUI

struct AdvancedCalculationDeciderView: View {
    @AppStorage("complexNumber") var complexNumber: Bool = false
    @AppStorage("polarForm") var polarForm: Bool = false
    
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"

    var body: some View {
        VStack {
            Text("What form are the complex numbers in?")
                .font(.title)
            
            Button{
                withAnimation{
                    complexNumber = false
                    polarForm = true
                }
            } label: {
                Text("Polar form")
                    .foregroundColor(Color("solve"))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20)
                        .frame(width: buttonWidth())
                        .foregroundColor(Color(standardOperator)))
                
            }
            .padding(.bottom)
            
            Button{
                withAnimation{
                    complexNumber = true
                    polarForm = false
                }
            } label: {
                Text("Rectangular Form")
                    .foregroundColor(Color("solve"))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20)
                        .frame(width: buttonWidth())
                        .foregroundColor(Color(standardOperator)))
            }
            .padding(.bottom)
        }
    }
    
    func buttonWidth() -> CGFloat {
        
        return (UIScreen.main.bounds.width ) / 2
    }
}

struct AdvancedCalculationDeciderView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCalculationDeciderView()
    }
}
