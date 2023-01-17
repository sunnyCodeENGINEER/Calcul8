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
    @Binding var selection: AdvancedCalculation
    
    @State var coordinateSystem: CoordinateSystem = .none
    
    var body: some View {
        if coordinateSystem == .cartesian {
            ZStack {
                AppBackgroundView()
                
                CartesianCoordinateView(coordinateSystem: $coordinateSystem, myColor: $standardButton, mySolveColor: $standardOperator)
                    .respectSafeARea()
            }
        } else if coordinateSystem == .cylindrical {
            ZStack {
                AppBackgroundView()
                
                CylindricalCoordinateView(coordinateSystem: $coordinateSystem, myColor: $standardButton, mySolveColor: $standardOperator)
                    .respectSafeARea()
            }
        } else if coordinateSystem == .spherical {
            ZStack {
                AppBackgroundView()
                
                SphericalCoordinateView(coordinateSystem: $coordinateSystem, myColor: $standardButton, mySolveColor: $standardOperator)
                    .respectSafeARea()
            }
        } else {
            ZStack {
                AppBackgroundView()
                
                CoordinateSystemDeciderView(coordinateSystem: $coordinateSystem, standardOperator: $standardOperator, selection: $selection)
                    .respectSafeARea()
            }
        }
    }
}

struct CoordinateSystemDecider_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateSystemDecider(selection: .constant(.none))
    }
}

struct RespectSafeArea: ViewModifier {
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top) {
                Color.clear
                    .frame( height: 40)
                    .padding(.bottom)
            }
    }
}

extension View {
    func respectSafeARea() -> some View {
        modifier(RespectSafeArea())
    }
    
    func keyboardRespectSafeArea() -> some View {
        modifier(KeyboardRespectSafeArea())
    }
}

struct KeyboardRespectSafeArea: ViewModifier {
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame( height: 40)
            }
    }
}
