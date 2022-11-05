//
//  RectangularCoordinateSystem.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 05/11/2022.
//

import SwiftUI

struct RectangularCoordinateSystem: View {
    @State var xAxis: String = ""
    @State var yAxis: String = ""
    @State var zAxis: String = ""
    
    @FocusState var isFocused: Bool
    
    
    var body: some View {
        HStack {
            TextField("0", text: $xAxis)
                .multilineTextAlignment(.trailing)
                .padding()
                .frame(width: textfieldWidth(), height: textfieldWidth())
                .background(.gray.opacity(0.3))
                .cornerRadius(15)
                .keyboardType(.numberPad)
                .focused($isFocused)
            Text("i ")
                .font(.title)
                .fontWeight(.heavy)
            Text("+")
            
            TextField("0", text: $yAxis)
                .multilineTextAlignment(.trailing)
                .padding()
                .frame(width: textfieldWidth(), height: textfieldWidth())
                .background(.gray.opacity(0.3))
                .cornerRadius(15)
                .keyboardType(.numberPad)
                .focused($isFocused)
            Text("j ")
                .font(.title)
                .fontWeight(.heavy)
            Text("+")
            
            TextField("0", text: $zAxis)
                .multilineTextAlignment(.trailing)
                .padding()
                .frame(width: textfieldWidth(), height: textfieldWidth())
                .background(.gray.opacity(0.3))
                .cornerRadius(15)
                .keyboardType(.numberPad)
                .focused($isFocused)
            Text("k ")
                .font(.title)
                .fontWeight(.heavy)
        }
    }
    func textfieldWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 6
    }
}

struct RectangularCoordinateSystem_Previews: PreviewProvider {
    static var previews: some View {
        RectangularCoordinateSystem()
    }
}

struct Rectangular {
    var xAxis, yAxis, zAxis: String
}
