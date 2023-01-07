//
//  CoordinateSystemDeciderView.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 06/01/2023.
//

import SwiftUI

struct CoordinateSystemDeciderView: View {
    @Binding var coordinateSystem: CoordinateSystem
    @Binding var standardOperator: String
    
    var body: some View {
        VStack {
            CoordinateButton(coordinateSystem: $coordinateSystem, setTo: .cartesian, title: "Cartesian Coordinate System", standardOperator: $standardOperator)
            CoordinateButton(coordinateSystem: $coordinateSystem, setTo: .cylindrical, title: "Cylindrical Coordinate System", standardOperator: $standardOperator)
            CoordinateButton(coordinateSystem: $coordinateSystem, setTo: .spherical, title: "Spherical Coordinate System", standardOperator: $standardOperator)
        }
    }
}

struct CoordinateSystemDeciderView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateSystemDeciderView(coordinateSystem: .constant(.none),standardOperator: .constant(""))
    }
}

struct CoordinateButton: View {
    @Binding var coordinateSystem: CoordinateSystem
    var setTo: CoordinateSystem
    var title: String
    @Binding var standardOperator: String
    
    var body: some View {
        Button {
            coordinateSystem = setTo
        } label: {
            Text(title)
                .foregroundColor(Color("solve"))
                .padding()
                .background(RoundedRectangle(cornerRadius: 20)
                    .frame(width: buttonWidth())
                    .foregroundColor(Color(standardOperator)))
        }
    }
    func buttonWidth() -> CGFloat {
        
        return (UIScreen.main.bounds.width ) / 1.5
    }
}
