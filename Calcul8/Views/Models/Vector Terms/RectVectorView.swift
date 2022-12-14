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
    
    @Binding var xComponent: CartesianCoordinateComponent
    @Binding var yComponent: CartesianCoordinateComponent
    @Binding var zComponent: CartesianCoordinateComponent
    @State var toFillComponent: CartesianTerms = CartesianTerms()
    
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
                        ComponentText(component: $xComponent)
                    }
                    Text(" i")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(String(xComponent.component.count))
                    HStack {
                        ForEach(xComponent.component) { component in
                            Text(component.coefficient)
                            ForEach(component.terms) { term in
                                Text(term.base)
                                Text(term.exponent)
                            }
                        }
                    }
                }
                
                HStack{
                    Text("+")
                    Button{
                        toFill = .yComp
                        nav = true
                    } label: {
                        ComponentText(component: $yComponent)
                    }
                    Text(" j")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(String(yComponent.component.count))
                    HStack {
                        ForEach(yComponent.component) { component in
                            Text(component.coefficient)
                            ForEach(component.terms) { term in
                                Text(term.base)
                                Text(term.exponent)
                            }
                        }
                    }
                }
                
                HStack{
                    Text("+")
                    Button{
                        toFill = .zComp
                        nav = true
                    } label: {
                        
                        ComponentText(component: $zComponent)
                    }
                    Text("k")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(String(zComponent.component.count))
                    HStack {
                        ForEach(zComponent.component) { component in
                            Text(component.coefficient)
                            ForEach(component.terms) { term in
                                Text(term.base)
                                Text(term.exponent)
                            }
                        }
                    }
                }
            }
            
            HStack {
                Spacer()
                
                Button {
                    showAnswer = true
//                    answerX = differentiate(base: "x".lowercased(), coefficient: trycoeff, component: tryComp, sign: trySign)
//                    divergence()
//                    xComponent = differentiateComponent(base: "x", component: xComponent)
                    curl()
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
//        xComponent.component[0].coefficient = subtraction(coeff1: xComponent.component[0].coefficient, term1: xComponent.component[0].terms, coeff2: xComponent.component[1].coefficient, term2: xComponent.component[1].terms).1
//        xComponent.component[0].terms = subtraction(coeff1: xComponent.component[0].coefficient, term1: xComponent.component[0].terms, coeff2: xComponent.component[1].coefficient, term2: xComponent.component[1].terms).2
        
        xComponent = subtraction2(component1: xComponent, component2: yComponent).1
    }
    
    func differentiateComponent(base: String, component: CartesianCoordinateComponent) -> CartesianCoordinateComponent {
        var returnComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
        
        component.component.forEach { comp in
            let tempCoefficient = differentiateRedo(base: base, coefficient: comp.coefficient, component: comp.terms).0
            let tempTerm = differentiateRedo(base: base, coefficient: comp.coefficient, component: comp.terms).1
            
            returnComponent.component.append(CartesianTerms(coefficient: tempCoefficient, terms: tempTerm))
        }
        print(returnComponent)
        return returnComponent
    }
    
    func differentiateRedo(base: String, coefficient: String, component: [Variable])-> (String, [Variable]) {
        var returnCoefficient: String = ""
        var returnComponent: [Variable] = []
        var mustReturn: [Variable] = []
        var a: Bool = false
        
        component.forEach { term in
            if term.base == base {
                mustReturn.append(Variable(base: base, exponent: String((Double(term.exponent) ?? 1) - 1)))
                returnCoefficient = String((Double(coefficient) ?? 1) * ((Double(term.exponent) ?? 1)))
                a = true
            } else {
                mustReturn.append(term)
            }
        }
        if returnCoefficient == "0.0" {
            a = false
        }
        
        if !a {
            mustReturn.removeAll()
            mustReturn.append(Variable(base: base, exponent: "0"))
        }
        
        returnComponent = mustReturn
        
        return (returnCoefficient, returnComponent)
    }
    
    func subtraction2(component1: CartesianCoordinateComponent, component2: CartesianCoordinateComponent) -> (Bool, CartesianCoordinateComponent){
        var returnComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
        var successful: Bool = false
        
//        var i = 0
//        var j = 0
        
        component1.component.forEach { comp in
            print(comp.getBases())
            var found = false
            component2.component.forEach { comp2 in
                if comp.getBases() == comp2.getBases() && comp.getExponents() == comp2.getExponents() {
                    returnComponent.component.append(CartesianTerms(coefficient: String((Double(comp.coefficient) ?? 1) - (Double(comp2.coefficient) ?? 1)), terms: comp.terms))
                    
                    found = true
                } else {
//                    returnComponent.append(CartesianCoordinateComponent(component: [comp2]))
                    returnComponent.component.append(comp2)
                }
            }
            if !found {
//                returnComponent.append(CartesianCoordinateComponent(component: [comp]))
                returnComponent.component.append(comp)
            }
        }
     
        return (successful, returnComponent)
    }
    
    func subtraction(coeff1: String, term1: [Variable],coeff2: String, term2: [Variable]) -> (Bool, String, [Variable]) {
        var firstTerm = term1
        var secondTerm = term2
        var i = 0
        var j = 0
        var continueIter = true
        var possibleAnswer: [Variable] = []
        var successful = false
        var answerVars: [Variable] = []
        var answerCoefficient: String = ""
        
        if firstTerm.count == secondTerm.count {
            while continueIter {
                while (i < firstTerm.count) {
                        if firstTerm[i].base == secondTerm[j].base && firstTerm[i].exponent == secondTerm[j].exponent{
                            possibleAnswer.append(Variable(base: firstTerm[i].base, exponent: String((Double(firstTerm[i].exponent) ?? 1))))
                            
                            firstTerm.remove(at: i)
                            secondTerm.remove(at: j)
                            i = -1
                            j = 0
                            answerCoefficient = String((Double(coeff1) ?? -1) - (Double(coeff2) ?? -1))
                            successful = true
                        } else {
                            successful = false
                            possibleAnswer.removeAll()
                            continueIter = false
                        }
                        i += 1
                    
                    answerVars.removeAll()
                    answerVars.append(contentsOf: possibleAnswer)
                   }
                
                continueIter = false
            }
        }
        
        return (successful, answerCoefficient, answerVars)
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

struct ComponentText: View {
    @Binding var component: CartesianCoordinateComponent
    
    var body: some View {
        HStack(alignment: .top, spacing: 1) {
            if component.component.isEmpty {
                HStack {
                    Text("Tap to enter")
                }
            }
            
            ForEach(0..<component.component.count, id: \.self) { i in
                Text(i == 0 ? "" : "+")
                Text(component.component[i].coefficient)
                ForEach(component.component[i].terms) { term in
                    if term.exponent != "0" {
                        Text(term.base)
                        if term.exponent != "1.0" {
                            Text(term.exponent)
                                .font(.caption2)
                        }
                    } else {
                        Text("1")
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.gray.opacity(0.4)))
    }
}
