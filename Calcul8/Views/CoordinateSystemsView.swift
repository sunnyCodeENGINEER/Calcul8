//
//  CoordinateSystemsView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 05/11/2022.
//

import SwiftUI

struct CoordinateSystemsView: View {
    @State var coordinteSystem: CoordinateSystems = .rectangular
    @State var operation: VectorOperation = .addition
    
    var body: some View {
        VStack{
            HStack {
                Text("Choose a coordinate system.")
                
                Picker(selection: $coordinteSystem, label: Text("Coordinate System") ){
                    Text("Rectangular").tag(CoordinateSystems.rectangular)
                    Text("Cylindrical").tag(CoordinateSystems.cylindrical)
                    Text("Spherical").tag(CoordinateSystems.spherical)
                }
            }
            
            RectangularCoordinateSystem()
            
            HStack {
                Text("Choose an operation.")
                
                Picker(selection: $operation, label: Text("Vector Operation") ){
                    Text("Addition").tag(VectorOperation.addition)
                    Text("Subtraction").tag(VectorOperation.subtraction)
                    Text("Dot Product").tag(VectorOperation.dotProduct)
                    Text("Cross Product").tag(VectorOperation.crossProduct)
                    Text("Magnitude").tag(VectorOperation.magnitude)
                    Text("Unit Vector").tag(VectorOperation.unitVector)
                    Text("Curl").tag(VectorOperation.curl)
                    Text("Divergence").tag(VectorOperation.divergence)
                    Text("Gradient").tag(VectorOperation.gradient)
                }
            }
            
            if operation != .magnitude || operation != .unitVector {
                withAnimation(.easeInOut) {
                    RectangularCoordinateSystem()
                }
            }
            
            HStack {
                Spacer()
                
                Button{
                    withAnimation {
                        //                    isFocused = false
                        //                    show = true
                    }
                    
                    //                    if operation != .convertToPolarForm {
                    //                        withAnimation{
                    //                            solveComplexNumberOperation()
                    //                        }
                    //                    } else {
                    //                        withAnimation {
                    //                        solveConversionToPolarForm()
                    //                        }
                    //                    }
                    
                } label: {
                    Text("Solve")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("solve"))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color("standardOperator")))
                }
                .padding(.bottom)
            }
            
            VStack {
                Divider()
            }
        }
    }
}

struct RectangulsrCoordinateSystem_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateSystemsView()
    }
}


