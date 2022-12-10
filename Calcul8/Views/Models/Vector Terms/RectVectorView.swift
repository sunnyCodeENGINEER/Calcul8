//
//  RectVectorView.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 10/11/2022.
//

import SwiftUI

struct RectVectorView: View {
    @State var coordinteSystem: CoordinateSystems = .rectangular
    @Binding var operation: VectorOperation
    
    @Binding var vector1XCoefficient: String
    @Binding var vector1YCoefficient: String
    @Binding var vector1ZCoefficient: String
    
    @Binding var vector2XCoefficient: String
    @Binding var vector2YCoefficient: String
    @Binding var vector2ZCoefficient: String
    
    @Binding var vector1XComp: [Variable]
    @Binding var vector1YComp: [Variable]
    @Binding var vector1ZComp: [Variable]
    
    @Binding var vector2XComp: [Variable]
    @Binding var vector2YComp: [Variable]
    @Binding var vector2ZComp: [Variable]
    
    @Binding var vector1XSign: Sign
    @Binding var vector1YSign: Sign
    @Binding var vector1ZSign: Sign
    
    @Binding var vector2XSign: Sign
    @Binding var vector2YSign: Sign
    @Binding var vector2ZSign: Sign
    
    @Binding var nav: Bool
    
    @Binding var toFill: ToFill
    
    @State var tryComp: [Variable] = [Variable(base: "x", exponent: "7"), Variable(base: "y", exponent: "12")]
    @State var trycoeff: String = "4"
    @State var trySign: Sign = .positive
    @State var showAnswer: Bool = false
    @State var answerX: (String, [Variable], Sign) = ("", [], .positive)
    @State var answerY: (String, [Variable], Sign) = ("", [], .positive)
    @State var answerZ: (String, [Variable], Sign) = ("", [], .positive)
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Choose a coordinate system.")
                
                Picker(selection: $coordinteSystem, label: Text("Coordinate System") ){
                    Text("Rectangular").tag(CoordinateSystems.rectangular)
                    Text("Cylindrical").tag(CoordinateSystems.cylindrical)
                    Text("Spherical").tag(CoordinateSystems.spherical)
                }
            }
            
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
            VStack(alignment: .trailing) {
                HStack {
                    Button{
                        toFill = .xComp
                        nav = true
                    } label: {
                        HStack(alignment: .top, spacing: 1) {
                            Text(vector1XCoefficient == "1" ? "" : vector1XCoefficient)
                            ForEach(vector1XComp, id: \.base) { term in
                                HStack(alignment: .top, spacing: 1) {
                                    Text(term.base)
                                    Text(term.exponent)
                                        .font(.caption2)
                                }
                            }
                            Text(vector2XSign == .positive ? "+" : "")
                            Text(vector2XCoefficient == "1" ? "" : vector2XCoefficient)
                            ForEach(vector2XComp, id: \.base) { term in
                                HStack(alignment: .top, spacing: 1) {
                                    Text(term.base)
                                    Text(term.exponent)
                                        .font(.caption2)
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.gray.opacity(0.4)))
                    }
                    Text(" i")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                HStack{
                    Text("+")
                    Button{
                        toFill = .yComp
                        nav = true
                    } label: {
                        HStack(alignment: .top, spacing: 1) {
                            Text(vector1YCoefficient == "1" ? "" : vector1YCoefficient)
                            ForEach(vector1YComp, id: \.base) { term in
                                HStack(alignment: .top, spacing: 1) {
                                    Text(term.base)
                                    Text(term.exponent)
                                        .font(.caption2)
                                }
                            }
                            Text(vector2YSign == .positive ? "+" : "")
                            Text(vector2YCoefficient)
                            ForEach(vector2YComp, id: \.base) { term in
                                HStack(alignment: .top, spacing: 1) {
                                    Text(term.base)
                                    Text(term.exponent)
                                        .font(.caption2)
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.gray.opacity(0.4)))
                    }
                    Text(" j")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                HStack{
                    Text("+")
                    Button{
                        toFill = .zComp
                        nav = true
                    } label: {
                        HStack(alignment: .top, spacing: 1) {
                            Text(vector1ZCoefficient == "1" ? "" : vector1ZCoefficient)
                            ForEach(vector1ZComp, id: \.base) { term in
                                HStack(alignment: .top, spacing: 1) {
                                    Text(term.base)
                                    Text(term.exponent)
                                        .font(.caption2)
                                }
                            }
                            Text(vector2ZSign == .positive ? "+" : "")
                            Text(vector2ZCoefficient == "1" ? "" : vector2ZCoefficient)
                            Text(vector2ZCoefficient)
                            ForEach(vector2ZComp, id: \.base) { term in
                                HStack(alignment: .top, spacing: 1) {
                                    Text(term.base)
                                    Text(term.exponent)
                                        .font(.caption2)
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.gray.opacity(0.4)))
                    }
                    Text("k")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            
            HStack {
                Spacer()
                
                Button {
                    showAnswer = true
//                    answerX = differentiate(base: "x".lowercased(), coefficient: trycoeff, component: tryComp, sign: trySign)
                    divergence()
                } label: {
                    Text("Solve")
                        .font(.title)
                        .padding()
                }
            }
            Divider()
            
            if showAnswer {
                HStack {
                    RectangularVectorAnswers(answer: $answerX, axis: .constant("i"))
                    Text("+")
                    RectangularVectorAnswers(answer: $answerY, axis: .constant("j"))
                    Text("+")
                    RectangularVectorAnswers(answer: $answerZ, axis: .constant("k"))
                }
            }
        }
    }
    func divergence() {
        answerX = differentiate(base: "x", coefficient: vector1XCoefficient, component: vector1XComp, sign: vector1XSign)
        answerY = differentiate(base: "y", coefficient: vector1YCoefficient, component: vector1YComp, sign: vector1YSign)
        answerZ = differentiate(base: "z", coefficient: vector1ZCoefficient, component: vector1ZComp, sign: vector1ZSign)
    }
    
    func curl() {
        
    }
    
    func differentiate(base: String, coefficient: String, component: [Variable], sign: Sign)-> (String, [Variable], Sign) {
        var returnCoefficient: String = coefficient
        var returnComponent: [Variable] = component
        var returnSign: Sign = sign
        var returnIndex = 0
        var mustReturn: [Variable] = []
        var a: Bool = false
        var coeffIndex = 0
//        var mustCoeff: String = ""
        
        // check if coefficient and component are empty
        if coefficient.isEmpty && component.isEmpty {
            returnComponent = []
            returnCoefficient = "0"
            returnSign = .positive
            mustReturn = []
        } else {
            while (returnIndex <= returnComponent.count) {
                // if current iteration has the desired base
                if returnComponent[returnIndex].base == base {
                    a = true
                    coeffIndex = returnIndex
                    returnCoefficient = String(Double(returnCoefficient)! * Double(returnComponent[returnIndex].exponent)!)
                    returnComponent[returnIndex].exponent = String(Double(returnComponent[returnIndex].exponent)! - 1)
                    
                    if (String(Double(returnComponent[returnIndex].exponent)! - 1)) != "0" {
                        mustReturn.append(Variable(base: returnComponent[returnIndex].base, exponent: String(Double(returnComponent[returnIndex].exponent)! - 1)))
                    }
                }
                
                if returnComponent[returnIndex].base != base {
                    mustReturn.append(returnComponent[returnIndex])
                }
                
                if (returnIndex + 1 == returnComponent.count) {
                    returnComponent = []
                    returnCoefficient = "0"
                    returnSign = .positive
                    if a {
                        returnComponent = mustReturn
                    }
                    break
                }
                returnIndex += 1
            }
            if a {
                returnCoefficient = String(Double(coefficient)! * Double(component[coeffIndex].exponent)!)
            } else {
                returnCoefficient = "0"
            }
        }
        return (returnCoefficient, returnComponent, returnSign)
    }
}

enum ToFill {
    case xComp, yComp, zComp, none
}

struct RectangularVectorAnswers: View {
    @Binding var answer: (String, [Variable], Sign)
    @Binding var axis: String
    
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 1) {
                Text(answer.0)
                ForEach(answer.1, id: \.base) { index in
                    if index.exponent != "0.0" {
                        HStack(alignment: .top, spacing: 1) {
                            Text(answer.2 == .negative ? "-" : "")
                            Text(index.base)
                            if index.exponent != "1.0" {
                                Text(index.exponent)
                                    .font(.caption2)
                            }
                        }
                    }
                }
            }
            Text(axis)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}
