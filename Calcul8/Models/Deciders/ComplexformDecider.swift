//
//  ComplexformDecider.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 28/04/2022.
//

import SwiftUI

struct ComplexformDecider: View {
    @AppStorage("complexNumber") var complexNumber: Bool = false
    @AppStorage("polarForm") var polarForm: Bool = false
    
    @Binding var selection: AdvancedCalculation
    
    var body: some View {
        if !complexNumber && !polarForm {
            AdvancedCalculationDeciderView(selection: $selection)
        }
        else {
            if complexNumber {
                withAnimation{
                    ComplexOperationView()
                }
            }
            else if polarForm {
                withAnimation{
                    PolarFormOperationView()
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
