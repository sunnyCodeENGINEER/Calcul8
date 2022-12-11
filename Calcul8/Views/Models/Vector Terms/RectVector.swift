//
//  RectVector.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 10/11/2022.
//

import SwiftUI

struct RectVector: View {
    @Binding var component: [Variable]
    @Binding var component2: [Variable]
    
    @State var var1: String = ""
    @State var var2: String = ""
    @State var var3: String = ""
    @State var exp1: String = ""
    @State var exp2: String = ""
    @State var exp3: String = ""
    
    @Binding var coefficient: String
    @Binding var coefficient2: String
    @Binding var sign: Sign
    @Binding var sign2: Sign
    
    @Binding var nav: Bool
    @State var addSecondTerm: Bool = false
    
//    @State var xComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
//    @State var yComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
//    @State var zComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
    @Binding var toFillComponent: CartesianCoordinateComponent
    @State var toFillTerms: CartesianTerms = CartesianTerms()
    @State var toFillTerms2: CartesianTerms = CartesianTerms()
    
    var body: some View {
        VStack {
            Text(addSecondTerm ? "Second Term" : "First Term")
            HStack(alignment: .top, spacing: 1) {
                Text(coefficient)
                ForEach(component, id: \.base) { term in
                    HStack(alignment: .top, spacing: 1) {
                        Text(term.base)
                        Text(term.exponent)
                            .font(.caption2)
                    }
                }
                
                Text(coefficient2)
                ForEach(component2, id: \.base) { term in
                    HStack(alignment: .top, spacing: 1) {
                        Text(term.base)
                        Text(term.exponent)
                            .font(.caption2)
                    }
                }
            }
            if !addSecondTerm {
                HStack {
                    Text("Coefficient")
                    TextField("Coefficient", text: $coefficient)
                        .keyboardType(.numberPad)
                    Picker("Sign", selection: $sign) {
                        Text("positive").tag(Sign.positive)
                        Text("negative").tag(Sign.negative)
                    }
                    .onChange(of: sign) {newValue in
                        if sign == .negative {
                            coefficient.insert("-", at: coefficient.startIndex)
                        } else {
                            coefficient.remove(at: coefficient.startIndex)
                        }
                    }
                }
                HStack {
                    VStack {
                        HStack {
                            Text("First Variable")
                            TextField("first variable...", text: $var1)
                        }
                        HStack{
                            Text("Exponent")
                            TextField("Exponent", text: $exp1)
                                .keyboardType(.numberPad)
                        }
                        
                    }
                    Button{
                        if !var1.isEmpty {
                            if exp1.isEmpty {
                                component.append(Variable(base: var1.lowercased(), exponent: "1"))
                                var1 = ""
                                exp1 = ""
                            } else {
                                component.append(Variable(base: var1.lowercased(), exponent: exp1))
                                var1 = ""
                                exp1 = ""
                            }
                        }
                    } label: {
                        Text("Done")
                            .padding()
                    }
                }
                HStack {
                    VStack {
                        HStack {
                            Text("second Variable")
                            TextField("second variable...", text: $var2)
                        }
                        HStack{
                            Text("Exponent")
                            TextField("Exponent", text: $exp2)
                                .keyboardType(.numberPad)
                        }
                        
                    }
                    Button{
                        if !var2.isEmpty {
                            if exp2.isEmpty {
                                component.append(Variable(base: var2.lowercased(), exponent: "1"))
                                var2 = ""
                                exp2 = ""
                            } else {
                                component.append(Variable(base: var2.lowercased(), exponent: exp2))
                                var2 = ""
                                exp2 = ""
                            }
                        }
                    } label: {
                        Text("Done")
                            .padding()
                    }
                }
                HStack {
                    VStack {
                        HStack {
                            Text("Third Variable")
                            TextField("third variable...", text: $var3)
                        }
                        HStack{
                            Text("Exponent")
                            TextField("Exponent", text: $exp3)
                                .keyboardType(.numberPad)
                        }
                        
                    }
                    Button{
                        if !var3.isEmpty {
                            if exp3.isEmpty {
                                component.append(Variable(base: var3.lowercased(), exponent: "1"))
                                var3 = ""
                                exp3 = ""
                            } else {
                                component.append(Variable(base: var3.lowercased(), exponent: exp3))
                                var3 = ""
                                exp3 = ""
                            }
                        }
                    } label: {
                        Text("Done")
                            .padding()
                    }
                }
            } else {
                HStack {
                    Text("Coefficient")
                    TextField("Coefficient", text: $coefficient2)
                        .keyboardType(.numberPad)
                    Picker("Sign", selection: $sign) {
                        Text("positive").tag(Sign.positive)
                        Text("negative").tag(Sign.negative)
                    }
                    .onChange(of: sign) {newValue in
                        if sign == .negative {
                            
                            coefficient2.insert("-", at: coefficient2.startIndex)
                        } else {
                            coefficient2.remove(at: coefficient2.startIndex)
                            if !coefficient2.isEmpty {
                                coefficient2.insert("+", at: coefficient2.startIndex)
                            }
                        }
                    }
                }
                HStack {
                    VStack {
                        HStack {
                            Text("First Variable")
                            TextField("first variable...", text: $var1)
                        }
                        HStack{
                            Text("Exponent")
                            TextField("Exponent", text: $exp1)
                                .keyboardType(.numberPad)
                        }
                        
                    }
                    Button{
                        if !var1.isEmpty {
                            if exp1.isEmpty {
                                component2.append(Variable(base: var1.lowercased(), exponent: "1"))
                                var1 = ""
                                exp1 = ""
                            } else {
                                component2.append(Variable(base: var1.lowercased(), exponent: exp1))
                                var1 = ""
                                exp1 = ""
                            }
                        }
                    } label: {
                        Text("Done")
                            .padding()
                    }
                }
                HStack {
                    VStack {
                        HStack {
                            Text("second Variable")
                            TextField("second variable...", text: $var2)
                        }
                        HStack{
                            Text("Exponent")
                            TextField("Exponent", text: $exp2)
                                .keyboardType(.numberPad)
                        }
                        
                    }
                    Button{
                        if !var2.isEmpty {
                            if exp2.isEmpty {
                                component2.append(Variable(base: var2.lowercased(), exponent: "1"))
                                var2 = ""
                                exp2 = ""
                            } else {
                                component2.append(Variable(base: var2.lowercased(), exponent: exp2))
                                var2 = ""
                                exp2 = ""
                            }
                        }
                    } label: {
                        Text("Done")
                            .padding()
                    }
                }
                HStack {
                    VStack {
                        HStack {
                            Text("Third Variable")
                            TextField("third variable...", text: $var3)
                        }
                        HStack{
                            Text("Exponent")
                            TextField("Exponent", text: $exp3)
                                .keyboardType(.numberPad)
                        }
                        
                    }
                    Button{
                        if !var3.isEmpty {
                            if exp3.isEmpty {
                                component2.append(Variable(base: var3.lowercased(), exponent: "1"))
                                var3 = ""
                                exp3 = ""
                            } else {
                                component2.append(Variable(base: var3.lowercased(), exponent: exp3))
                                var3 = ""
                                exp3 = ""
                            }
                        }
                    } label: {
                        Text("Done")
                            .padding()
                    }
                }
            }
//            ForEach(component, id: \.base) { term in
//                HStack {
//                    Text(term.base)
//                    Text(term.exponent)
//                }
//            }
            HStack {
                Button {
                    var1 = ""
                    exp1 = ""
                    var2 = ""
                    exp2 = ""
                    var3 = ""
                    exp3 = ""
                    if addSecondTerm {
                        component2.removeAll()
                    } else {
                        component.removeAll()
                    }
                    
                } label: {
                    Text("Clear")
                }
                Button {
                    
                } label: {
                    Text("Save")
                }
            }
            
            Button {
                var1 = ""
                exp1 = ""
                var2 = ""
                exp2 = ""
                var3 = ""
                exp3 = ""
                addSecondTerm.toggle()
            } label: {
                Text(addSecondTerm ? "Review First Term" : "Add second term.")
            }
            
            Button {
                if coefficient.isEmpty {
                    if !component.isEmpty {
                        coefficient = "1"
                    }
                }
                if coefficient2.isEmpty {
                    if !component2.isEmpty {
                        coefficient2 = "1"
                    }
                }
                
                // make sure toFillComponent is empty
//                toFillComponent.component.removeAll()
                
                // save user inputs to CartesianComponent
                var present = false
                if !component.isEmpty {
                    toFillTerms.terms.append(contentsOf: component)
                    present = true
                }
                if !coefficient.isEmpty {
                    toFillTerms.coefficient = coefficient
                    if !present {
                        toFillTerms.terms.append(Variable(base: "x", exponent: "0"))
                    }
                }
                toFillComponent.component.append(toFillTerms)
                toFillTerms.terms.removeAll()
                toFillTerms.coefficient.removeAll()
                
                // second term
                var present2 = false
                if !component2.isEmpty {
                    toFillTerms2.terms.append(contentsOf: component2)
                    present2 = true
                }
                if !coefficient2.isEmpty {
                    toFillTerms2.coefficient = coefficient
                    if !present2 {
                        toFillTerms.terms.append(Variable(base: "x", exponent: "0"))
                    }
                }
                
                print(toFillComponent.component.count)
                print(toFillComponent)
                
                
                nav = false
            }label: {
                Text("Done")
            }
        }
        
    }
    func assign(variable: String, expo: String)-> String {
        if !variable.isEmpty {
            if expo.isEmpty {
                component.append(Variable(base: variable.lowercased(), exponent: "1"))
                
                
            } else {
                component.append(Variable(base: variable.lowercased(), exponent: expo))
                
            }
        }
        return ""
    }
}

//struct RectVector_Previews: PreviewProvider {
//    static var previews: some View {
//        RectVector(component: .constant([]), coefficient: .constant(""), sign: .constant(.positive), nav: .constant(false))
//    }
//}

struct Variable {
    @State var base: String
    @State var exponent: String
}

enum Sign {
    case positive, negative
}
