//
//  AdvancedCalculationNavigator.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 08/12/2022.
//

import SwiftUI

struct AdvancedCalculationNavigator: View {
    @State var selection: AdvancedCalculation = .none
    @State var operation: VectorOperation = .addition
    
    var body: some View {
        if selection == .none {
            AdvancedCalculationListView(selection: $selection)
        } else if selection == .complex {
            ComplexformDecider(selection: $selection)
        } else if selection == .vector {
//            CoordinateSystemsView(operation: $operation)
            RectangularVectorComponentDecider(selection: $selection)
        } else if selection == .algebra {
            
        }
    }
}

struct AdvancedCalculationNavigator_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCalculationNavigator()
    }
}
