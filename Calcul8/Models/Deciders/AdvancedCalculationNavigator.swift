//
//  AdvancedCalculationNavigator.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 08/12/2022.
//

import SwiftUI

struct AdvancedCalculationNavigator: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @State var selection: AdvancedCalculation = .none
    @State var operation: VectorOperation = .addition
    
    var body: some View {
        if selection == .none {
            ZStack {
                AppBackgroundView()
                
                AdvancedCalculationListView(selection: $selection)
                    .respectSafeARea()
            }
        } else if selection == .complex {
            ComplexformDecider(selection: $selection)
        } else if selection == .vector {
            CoordinateSystemDecider(selection: $selection)
        } else if selection == .algebra {
            ZStack {
                AppBackgroundView()
                
                VStack {
                    AlgebraViewRedo(selection: $selection)
    //                    .padding(.horizontal)
                        
                    .respectSafeARea()
                }.frame(width: UIScreen.main.bounds.width)
            }
            
        }
    }
}

struct AdvancedCalculationNavigator_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCalculationNavigator()
    }
}
