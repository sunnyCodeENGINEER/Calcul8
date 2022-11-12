//
//  CoordinateSystemsView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 05/11/2022.
//

import SwiftUI

struct CoordinateSystemsView: View {
    @State var coordinteSystem: CoordinateSystems = .rectangular
    @Binding var operation: VectorOperation
    
    @State var vector1: Rectangular = Rectangular(xAxis: "3", yAxis: "-3", zAxis: "1")
    @State var vector2: Rectangular = Rectangular(xAxis: "4", yAxis: "9", zAxis: "2")
    @State var answer: Rectangular = Rectangular(xAxis: "", yAxis: "", zAxis: "")
    @State var scalarAnswer: String = ""
    @State var doubleAnswer: Double = 0
    
    @State var show: Bool = false
    @FocusState var isFocused
    
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
                        isFocused = false
                        show = true
                    }
                    
                    switch operation {
                    case .addition:
                        withAnimation(.easeInOut) {
                            answer = addition()
                        }
                    case .subtraction:
                        withAnimation(.easeInOut) {
                            answer = subtraction()
                        }
                    case .dotProduct:
                        withAnimation(.easeInOut) {
                            scalarAnswer = dotProduct()
                        }
                    case .crossProduct:
                        withAnimation(.easeInOut) {
                            answer = crossProduct()
                        }
                    case .magnitude:
                        withAnimation(.easeInOut) {
                            doubleAnswer = magnitude()
                        }
                    case .unitVector:
                        withAnimation(.easeInOut) {
                            answer = unitVectot()
                        }
                    case .curl:
                        break
                    case .divergence:
                        break
                    case .gradient:
                        break
                    }
                    //                    if operation == .addition {
                    //                        withAnimation(.easeInOut) {
                    //                            answer = addition()
                    //                        }
                    //                    }
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
                .padding(.trailing)
            }
            
            VStack {
                Divider()
                
                if show {
                    VStack {
                        Text("Answer".uppercased())
                            .font(.title)
                    }
                    
                    if operation == .dotProduct {
                        Text(scalarAnswer)
                    }
                    else if operation == .magnitude {
                        Text(String(format: "%.4f", doubleAnswer))
                    }else {
                        HStack{
                            Text(answer.xAxis)
                            Text("i ")
                                .font(.title)
                                .fontWeight(.bold)
                            Text(Double(answer.yAxis)! >= 0 ? "+" : "")
                            Text(" \(answer.yAxis)")
                            Text("j")
                                .font(.title)
                                .fontWeight(.bold)
                            Text(Double(answer.zAxis)! >= 0 ? "+" : "")
                            Text(" \(answer.zAxis)")
                            Text("k")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding(.top)
                    }
                }
            }
        }
    }
    
    
    func addition()-> Rectangular {
        var sum: Rectangular = Rectangular(xAxis: "", yAxis: "", zAxis: "")
        
        sum.xAxis = String((Double(vector1.xAxis)! ) + (Double(vector2.xAxis)! ))
        sum.yAxis = String((Double(vector1.yAxis)! ) + (Double(vector2.yAxis)! ))
        sum.zAxis = String((Double(vector1.zAxis)! ) + (Double(vector2.zAxis)! ))
        
        return sum
    }
    
    func subtraction()-> Rectangular {
        var diff: Rectangular = Rectangular(xAxis: "", yAxis: "", zAxis: "")
        
        diff.xAxis = String((Double(vector1.xAxis)! ) - (Double(vector2.xAxis)! ))
        diff.yAxis = String((Double(vector1.yAxis)! ) - (Double(vector2.yAxis)! ))
        diff.zAxis = String((Double(vector1.zAxis)! ) - (Double(vector2.zAxis)! ))
        
        return diff
    }
    
    func dotProduct()-> String {
        let dot = String(Double((vector1.xAxis))! * Double((vector2.xAxis))! + Double((vector1.yAxis))! * Double((vector2.yAxis))! + Double((vector1.zAxis))! * Double((vector2.zAxis))!)
        
        return dot
    }
    
    func crossProduct()-> Rectangular {
        var cross: Rectangular = Rectangular(xAxis: "", yAxis: "", zAxis: "")
        
        cross.xAxis = String(((Double(vector1.yAxis)! ) * (Double(vector2.zAxis)! )) - ((Double(vector1.zAxis)! ) * (Double(vector2.yAxis)! )))
        cross.yAxis = String(((Double(vector1.zAxis)! ) * (Double(vector2.xAxis)! )) - ((Double(vector1.xAxis)! ) * (Double(vector2.zAxis)! )))
        cross.zAxis = String(((Double(vector1.xAxis)! ) * (Double(vector2.yAxis)! )) - ((Double(vector1.yAxis)! ) * (Double(vector2.xAxis)! )))
        
        return cross
    }
    
    func magnitude()-> Double {
        let magnitude = Double(sqrt((Double(vector1.xAxis)! * Double(vector1.xAxis)!) + (Double(vector1.yAxis)! * Double(vector1.yAxis)!) + (Double(vector1.zAxis)! * Double(vector1.zAxis)!)))
        
        return magnitude
    }
    
    func unitVectot()-> Rectangular {
        let magnitude = magnitude()
        
        var unitVector: Rectangular = Rectangular(xAxis: "", yAxis: "", zAxis: "")
        
        let xAxis = (Double(vector1.xAxis)! / magnitude)
        let yAxis = (Double(vector1.yAxis)! / magnitude)
        let zAxis = (Double(vector1.zAxis)! / magnitude)
        
        unitVector.xAxis = String(format: "%.4f", xAxis)
        unitVector.yAxis = String(format: "%.4f", yAxis)
        unitVector.zAxis = String(format: "%.4f", zAxis)
        
        return unitVector
    }
}

struct RectangulsrCoordinateSystem_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateSystemsView(operation: .constant(.addition))
    }
}


