//
//  ComplexformDecider.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 28/04/2022.
//

import SwiftUI

struct ComplexformDecider: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @AppStorage("complexNumber") var complexNumber: Bool = false
    @AppStorage("polarForm") var polarForm: Bool = false
    
    @Binding var selection: AdvancedCalculation
    
    var body: some View {
        if !complexNumber && !polarForm {
            ZStack {
                AppBackgroundView()
                
                AdvancedCalculationDeciderView(selection: $selection)
                    .respectSafeARea()
            }
        }
        else {
            if complexNumber {
                withAnimation{
                    ZStack {
                        AppBackgroundView()
                        
                        ComplexOperationView(solveColor: $standardOperator, textfieldBackground: $standardButton)
                            .respectSafeARea()
                    }
                }
            }
            else if polarForm {
                withAnimation{
                    ZStack {
                        AppBackgroundView()
                        
                        PolarFormOperationView(solveColor: $standardOperator, textfieldBackground: $standardButton)
                            .respectSafeARea()
                            
                    }
                }
            }
        }
    }
}

struct ComplexformDecider_Previews: PreviewProvider {
    static var previews: some View {
        ComplexformDecider(selection: .constant(.none))
    }
}
