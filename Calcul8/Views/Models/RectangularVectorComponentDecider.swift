//
//  RectangularVectorComponentDecider.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 12/11/2022.
//

import SwiftUI

struct RectangularVectorComponentDecider: View {
    @State var operation: VectorOperation = .addition
    @Binding var selection: AdvancedCalculation
    
    var body: some View {
        VStack {
            if operation == .curl {
                RectNavView(operation: $operation)
            } else if operation == .divergence {
                RectNavView(operation: $operation)
            } else if operation == .gradient {
                RectNavView(operation: $operation)
            } else {
                CoordinateSystemsView(operation: $operation, selection: $selection)
            }
        }
    }
}

struct RectangularVectorComponentDecider_Previews: PreviewProvider {
    static var previews: some View {
        RectangularVectorComponentDecider(selection: .constant(.none))
    }
}
