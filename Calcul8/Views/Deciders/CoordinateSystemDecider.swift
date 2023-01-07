//
//  CoordinateSystemDecider.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 15/12/2022.
//

import SwiftUI

struct CoordinateSystemDecider: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @AppStorage("buttonRadius") var buttonRadius: Double = 0.0
    
    @State var coordinateSystem: CoordinateSystem = .none
    
    var body: some View {
        if coordinateSystem == .cartesian {
            CartesianCoordinateView(coordinateSystem: $coordinateSystem, myColor: $standardButton, mySolveColor: $standardOperator)
        } else if coordinateSystem == .cylindrical {
            CylindricalCoordinateView(coordinateSystem: $coordinateSystem, myColor: $standardButton, mySolveColor: $standardOperator)
        } else if coordinateSystem == .spherical {
            SphericalCoordinateView(coordinateSystem: $coordinateSystem, myColor: $standardButton, mySolveColor: $standardOperator)
        } else {
            CoordinateSystemDeciderView(coordinateSystem: $coordinateSystem, standardOperator: $standardOperator)
        }
    }
}

struct CoordinateSystemDecider_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateSystemDecider()
    }
}
