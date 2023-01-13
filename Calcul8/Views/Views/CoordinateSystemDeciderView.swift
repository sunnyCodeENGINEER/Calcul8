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
    @Binding var selection: AdvancedCalculation
    
    @State private var animateLogo: Bool = false
    @State private var showMenu: Bool = false
    @State private var menuOpacity: Bool = false
    @State private var width: CGFloat = UIScreen.main.bounds.width / 8
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    HStack {
                        Button {
                            selection = .none
                        } label: {
                            Image(systemName: "chevron.left")
                            Text("Back")
                                
                        }
                        .tint(Color(standardOperator))
                        .padding(.leading)
                        Spacer()
                    }
                    Spacer()
                }
                
                VStack {
                    Text("Choose a vector coordinate system.")
                        .font(.title)
                        .padding()
                    
                    CoordinateButton(coordinateSystem: $coordinateSystem, setTo: .cartesian, title: "Cartesian Coordinate System", standardOperator: $standardOperator)
                        .shadow(color: .black, radius: 10, x: -5, y: 5)
                        .padding(.bottom)
                    CoordinateButton(coordinateSystem: $coordinateSystem, setTo: .cylindrical, title: "Cylindrical Coordinate System", standardOperator: $standardOperator)
                        .shadow(color: .black, radius: 10, x: -5, y: 5)
                        .padding(.bottom)
                    CoordinateButton(coordinateSystem: $coordinateSystem, setTo: .spherical, title: "Spherical Coordinate System", standardOperator: $standardOperator)
                        .shadow(color: .black, radius: 10, x: -5, y: 5)
                        .padding(.bottom)
                }
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
        }
    }
}

struct CoordinateSystemDeciderView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateSystemDeciderView(coordinateSystem: .constant(.none),standardOperator: .constant(""), selection: .constant(.none))
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
                    .foregroundColor(Color(standardOperator))
                    .blur(radius: 1))
        }
    }
    func buttonWidth() -> CGFloat {
        
        return (UIScreen.main.bounds.width ) / 1.5
    }
}
