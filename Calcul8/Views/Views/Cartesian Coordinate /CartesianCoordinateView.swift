//
//  CartesianCoordinateView.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 15/12/2022.
//

import SwiftUI

struct CartesianCoordinateView: View {
    @Binding var coordinateSystem: CoordinateSystem
    @Binding var myColor: String
    @Binding var mySolveColor: String
    
    @State private var vector1: CartesianCoordinateSystem = CartesianCoordinateSystem()
    @State private var vector2: CartesianCoordinateSystem = CartesianCoordinateSystem()
    @State private var answerVector: CartesianCoordinateSystem = CartesianCoordinateSystem()
    
    @State private var component: CartesianTerms = CartesianTerms()
    @State private var variable: Variable = Variable()
    @State private var operation: VectorOperation = .addition
    @State private var currentComponent: String = "i"
    @State private var recieveComponents: Bool = false
    @State private var showAnswer: Bool = false
    @State private var variables: Bool = false
    @State private var currentVector: Int = 1
    @State private var trignometry: Bool = false
    @State var exponents: Bool = false
    
    @State var animateLogo: Bool = false
    @State var showMenu: Bool = false
    @State var menuOpacity: Bool = false
    @State var width: CGFloat = UIScreen.main.bounds.width / 8
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button{
                        withAnimation{
                            coordinateSystem = .none
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .tint(Color(mySolveColor))
                    .padding(.leading)
                    
                    Spacer()
                }
                
                Spacer()
                
                if operation != .gradient {
                    VStack {
                        MyVectorTextField(vector: $vector1, receiveComponents: $recieveComponents, title: "Vector 1", currentVector: $currentVector, setTo: 1, myColor: $myColor, borderColor: $mySolveColor)
                        DoneButtonDecider(vector: $vector1, component: $component, variable: $variable, currentComponent: $currentComponent)
                            .tint(Color(mySolveColor))
                        OperationPicker(operation: $operation)
                            .tint(Color(mySolveColor))
                        if operation != .curl && operation != .divergence && operation != .unitVector && operation != .magnitude {
                            MyVectorTextField(vector: $vector2, receiveComponents: $recieveComponents, title: "Vector 2", currentVector: $currentVector, setTo: 2, myColor: $myColor, borderColor: $mySolveColor)
                            DoneButtonDecider(vector: $vector2, component: $component, variable: $variable, currentComponent: $currentComponent)
                                .tint(Color(mySolveColor))
                        }
                        SolveButton(vector1: $vector1, vector2: $vector2, answerVector: $answerVector, receiveComponent: $recieveComponents, showAnser: $showAnswer, operation: $operation, myColor: $mySolveColor)
                    }
                } else {
                    FunctionField(function: $vector1.xComponent, receiveComponents: $recieveComponents, myColor: $myColor, borderColor: $mySolveColor)
                    OperationPicker(operation: $operation)
                        .tint(Color(mySolveColor))
                    HStack {
                        //                    ClearAll(vector: $vector1)
                        ClearButton(axis: $vector1.xComponent)
                            .tint(Color(mySolveColor))
                        DoneButton(axis: $vector1.xComponent, component: $component, variable: $variable, currentComponent: $currentComponent)
                            .tint(Color(mySolveColor))
                    }
                    SolveButton(vector1: $vector1, vector2: $vector2, answerVector: $answerVector, receiveComponent: $recieveComponents, showAnser: $showAnswer, operation: $operation, myColor: $mySolveColor)
                    
                }
                VStack {
                    if recieveComponents {
    //                    ComponentSelectorRow(axis: $axis, component: $component, variable: $variable,currentComponent: $currentComponent)
                        if operation != .gradient {
                            ComponentSelectorDecider(vector1: $vector1, vector2: $vector2, component: $component, variable: $variable, currentComponent: $currentComponent, currentVector: $currentVector)
                        }
                        HStack {
                            VariableConstantButton(title: variables ? "Conatants" : "Variables", variables: $variables, mySolveColor: $mySolveColor)
                            
                            CartesianComponentDecider(vector1: $vector1, vector2: $vector2, component: $component, variable: $variable, currentComponent: $currentComponent, currentVector: $currentVector, exponents: $exponents)
                        }
                        if !variables {
                            VectorKeyBoard(component: $component, variable: $variable, mySolveColor: $mySolveColor, myColor: $myColor)
                        } else {
                            VectorKeyBoardVariables(exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, mySolveColor: $mySolveColor, myColor: $myColor)
                        }
                    }
                    if showAnswer {
                        AnswerBoard(answerVector: $answerVector)
                    }
                }
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
        }
    }
}

struct CartesianCoordinateView_Previews: PreviewProvider {
    static var previews: some View {
        CartesianCoordinateView(coordinateSystem: .constant(.cartesian), myColor: .constant(""), mySolveColor: .constant(""))
    }
}

struct FunctionField: View {
    @Binding var function: CartesianCoordinateComponent
    @Binding var receiveComponents: Bool
    @Binding var myColor: String
    @Binding var borderColor: String
    
    var body: some View {
        VStack {
            Text("function".uppercased())
                .padding(.leading)
            HStack {
                Button {
                    withAnimation(.easeInOut) {
                        receiveComponents = true
                    }
                } label: {
                    HStack(spacing: 2) {
                        MyText(axis: $function)
                        
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(myColor).opacity(0.5)))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2).foregroundColor(Color(borderColor)))
                }
            }
        }
    }
}

struct ClearAll: View {
    @Binding var vector: CartesianCoordinateSystem
    
    
    var body: some View {
        HStack {
            Button {
                vector.xComponent.component.removeAll()
                vector.yComponent.component.removeAll()
                vector.zComponent.component.removeAll()
            } label: {
                Text("Clear All")
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2))
            }
        }
    }
}

struct ClearButton: View {
    @Binding var axis: CartesianCoordinateComponent
//    @Binding var component: CartesianTerms
//    @Binding var variable: Variable
//    @Binding var currentComponent: String
    
    var body: some View {
        HStack{
            Button {
                axis.component.removeAll()
            } label: {
                Text("Clear")
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2))
            }
        }
    }
}

struct DoneButton: View {
    @Binding var axis: CartesianCoordinateComponent
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    
    var body: some View {
        HStack {
            Button {
                if !variable.base.isEmpty {
                    if !variable.exponent.isEmpty {
                        component.terms.append(Variable(base: variable.base, exponent: variable.exponent))
                    } else {
                        component.terms.append(Variable(base: variable.base, exponent: "1"))
                    }
                }
                
                if component.coefficient.isEmpty {
                    if !component.terms.isEmpty {
                        axis.component.append(CartesianTerms(coefficient: "1", terms: component.terms))
                    }
                } else {
                    if !component.terms.isEmpty {
                        axis.component.append(CartesianTerms(coefficient: component.coefficient, terms: component.terms))
                    } else {
                        axis.component.append(CartesianTerms(coefficient: component.coefficient))
                    }
                }
                
                variable = Variable()
                component.coefficient.removeAll()
                component.terms.removeAll()
                
            } label: {
                Text("Done")
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2))
            }
        }
    }
}

struct AnswerBoard: View {
    @Binding var answerVector: CartesianCoordinateSystem
    
    var body: some View {
        HStack(spacing: 2) {
            if !answerVector.xComponent.component.isEmpty {
                Text("(")
                MyText(axis: $answerVector.xComponent)
                Text(")")
                Text("i")
            }
            if !answerVector.yComponent.component.isEmpty {
                Text("+")
                Text("(")
                MyText(axis: $answerVector.yComponent)
                Text(")")
                Text("j")
            }
            if !answerVector.zComponent.component.isEmpty {
                Text("+")
                Text("(")
                MyText(axis: $answerVector.zComponent)
                Text(")")
                Text("k")
            }
        }
    }
}

struct SolveButton: View {
    @Binding var vector1: CartesianCoordinateSystem
    @Binding var vector2: CartesianCoordinateSystem
    @Binding var answerVector: CartesianCoordinateSystem
    @Binding var receiveComponent: Bool
    @Binding var showAnser: Bool
    @Binding var operation: VectorOperation
    @Binding var myColor: String
    
    var body: some View {
        HStack {
            Spacer()
            Button{
                solve(vector1: vector1, vector2: vector2, operation: operation)
                
                
                vector1 = sortVector(vector1)
                vector1.xComponent = sortComponent(component: vector1.xComponent)
                
                
                receiveComponent = false
                showAnser = true
            } label: {
                Text("Solve")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("solve"))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(myColor)))
                    .padding()
            }
        }
    }
    private func sortVector(_ vector: CartesianCoordinateSystem) -> CartesianCoordinateSystem {
        var answer: CartesianCoordinateSystem = CartesianCoordinateSystem()
        
        answer.xComponent = sortTerms(component: vector.xComponent)
        answer.yComponent = sortTerms(component: vector.yComponent)
        answer.zComponent = sortTerms(component: vector.zComponent)
        
        return answer
    }
    
    private func sortComponent(component: CartesianCoordinateComponent) -> CartesianCoordinateComponent {
        var toSetExpression: CartesianCoordinateComponent = CartesianCoordinateComponent()
        var express = component
        
        // algorithm used -> BUBBLE SORT
        // loop to access each array element
        for i in (0..<express.component.count) {
                // loop to compare array elements
            for j in (0..<((express.component.count) - (i + 1))) {
                    // compare two adjacent elements
                    // change > to < to sort in descending order
                if express.component[j].getBases() > express.component[j + 1].getBases() {
                    // swapping elements if elements are not in intended order
                    let temp = express.component[j]
                    express.component[j] = express.component[j + 1]
                    express.component[j + 1] = temp
                }
                
                // swap elements according to their exponents
                if express.component[j].getBases() == express.component[j + 1].getBases() {
                    // swapping elements if elements are not in intended order
                    if express.component[j].getExponents() > express.component[j + 1].getExponents() {
                        // swapping elements if elements are not in intended order
                        let temp = express.component[j]
                        express.component[j] = express.component[j + 1]
                        express.component[j + 1] = temp
                    }
                    
                    
                }
            }
            
            toSetExpression = express
        }
        
        return toSetExpression
    }
    
    private func sortTerms(component: CartesianCoordinateComponent) -> CartesianCoordinateComponent {
        var toSetExpression: CartesianCoordinateComponent = CartesianCoordinateComponent()
        var toSetTerm: [Variable] = []
        
        // algorithm used -> BUBBLE SORT
        component.component.forEach { express in
            toSetTerm = express.terms
            // loop to access each array element
            for i in (0..<toSetTerm.count) {
                // loop to compare array elements
                for j in (0..<((toSetTerm.count) - (i + 1))) {
                    // compare two adjacent elements
                    // change > to < to sort in descending order
                    if toSetTerm[j].base > toSetTerm[j + 1].base {
                        // swapping elements if elements are not in intended order
                        let temp = toSetTerm[j]
                        toSetTerm[j] = toSetTerm[j + 1]
                        toSetTerm[j + 1] = temp
                    }
                    
                }
            }
            
//            toSetExpression.component.append(Variable(coefficient: express.coefficient, terms: toSetTerm))
            toSetExpression.component.append(CartesianTerms(coefficient: express.coefficient, terms: toSetTerm))

            toSetTerm.removeAll()
        }
        return toSetExpression
    }
    
    private func solve(vector1: CartesianCoordinateSystem, vector2: CartesianCoordinateSystem, operation: VectorOperation) {
        switch operation {
        case .addition:
            answerVector = addition(vector1, vector2)
            break
        case .subtraction:
            answerVector = subtraction(vector1, vector2)
            break
        case .dotProduct:
            answerVector.xComponent = dotProduct(vector1, vector2).xComponent
            break
        case .crossProduct:
            answerVector = crossProduct(vector1, vector2)
            break
        case .scalarMultiplication:
            break
        case .unitVector:
            answerVector = unitVector(vector1)
            break
        case .magnitude:
            answerVector.xComponent = magnitude(vector1).xComponent
            break
        case .curl:
            answerVector = curl(vector1.xComponent, vector1.yComponent, vector1.zComponent)
            break
        case .divergence:
            answerVector = divergence(vector1)
            break
        case .gradient:
            answerVector = gradient(vector1.xComponent)
            break
        }
        
    }
    
    private func addition(_ vector1: CartesianCoordinateSystem, _ vector2: CartesianCoordinateSystem) -> CartesianCoordinateSystem {
        var returnVector: CartesianCoordinateSystem = CartesianCoordinateSystem()
        
        func check(comp1: CartesianTerms, comp2: [CartesianTerms]) -> Bool {
            var isPresent: Bool = false
            
            comp2.forEach{ term in
                if term.getBases() == comp1.getBases() && term.getExponents() == term.getExponents() {
                    isPresent = true
                }
            }
            
            return isPresent
        }
        
        // loop over every component of each vector
        var added: [CartesianTerms] = []
        vector1.xComponent.component.forEach { component in
            
            vector2.xComponent.component.forEach { component2 in
                // if getBase() and getExpomnents() are equal append terms and sum of coefficient to corressponding component of returnVector
                if component.getBases() == component2.getBases() && component.getExponents() == component2.getExponents() {
                    returnVector.xComponent.component.append(CartesianTerms(coefficient: String((Double(component.coefficient) ?? 1) + (Double(component2.coefficient) ?? 1)), terms: component.terms))
                } else {
                    returnVector.xComponent.component.append(CartesianTerms(coefficient: component.coefficient, terms: component.terms))
                    if !(check(comp1: component2, comp2: added)) {
                        added.append(component2)
                    }
                }
            }
        }
        
        added.forEach { term in
            returnVector.xComponent.component.append(CartesianTerms(coefficient: "+" + term.coefficient, terms: term.terms))
        }
        
        if vector1.xComponent.component.isEmpty {
            returnVector.xComponent.component.append(contentsOf: vector2.xComponent.component)
        }
        if vector2.xComponent.component.isEmpty {
            returnVector.xComponent.component.append(contentsOf: vector1.xComponent.component)
        }
        
        added.removeAll()
        
        vector1.yComponent.component.forEach { component in
            vector2.yComponent.component.forEach { component2 in
                // if getBase() and getExpomnents() are equal append terms and sum of coefficient to corressponding component of returnVector
                if component.getBases() == component2.getBases() && component.getExponents() == component2.getExponents() {
                    returnVector.yComponent.component.append(CartesianTerms(coefficient: String((Double(component.coefficient) ?? 1) + (Double(component2.coefficient) ?? 1)), terms: component.terms))
                } else {
                    returnVector.yComponent.component.append(CartesianTerms(coefficient: component.coefficient, terms: component.terms))
//                    returnVector.yComponent.component.append(CartesianTerms(coefficient: "+" + component2.coefficient, terms: component2.terms))
                    if !(check(comp1: component2, comp2: added)) {
                        added.append(component2)
                    }
                }
            }
        }
        
        added.forEach { term in
            returnVector.yComponent.component.append(CartesianTerms(coefficient: "+" + term.coefficient, terms: term.terms))
        }
        
        if vector1.yComponent.component.isEmpty {
            returnVector.yComponent.component.append(contentsOf: vector2.yComponent.component)
        }
        if vector2.yComponent.component.isEmpty {
            returnVector.yComponent.component.append(contentsOf: vector1.yComponent.component)
        }
        
        added.removeAll()
        
        vector1.zComponent.component.forEach { component in
            vector2.zComponent.component.forEach { component2 in
                // if getBase() and getExpomnents() are equal append terms and sum of coefficient to corressponding component of returnVector
                if component.getBases() == component2.getBases() && component.getExponents() == component2.getExponents() {
                    returnVector.zComponent.component.append(CartesianTerms(coefficient: String((Double(component.coefficient) ?? 1) + (Double(component2.coefficient) ?? 1)), terms: component.terms))
                } else {
                    returnVector.zComponent.component.append(CartesianTerms(coefficient: component.coefficient, terms: component.terms))
//                    returnVector.zComponent.component.append(CartesianTerms(coefficient: "+" + component2.coefficient, terms: component2.terms))
                    if !(check(comp1: component2, comp2: added)) {
                        added.append(component2)
                    }
                }
            }
        }
        
        added.forEach { term in
            returnVector.zComponent.component.append(CartesianTerms(coefficient: "+" + term.coefficient, terms: term.terms))
        }
        
        if vector1.zComponent.component.isEmpty {
            returnVector.zComponent.component.append(contentsOf: vector2.zComponent.component)
        }
        if vector2.zComponent.component.isEmpty {
            returnVector.zComponent.component.append(contentsOf: vector1.zComponent.component)
        }
        
        return returnVector
    }
    
    private func subtraction(_ vector1: CartesianCoordinateSystem, _ vector2: CartesianCoordinateSystem) -> CartesianCoordinateSystem {
        var returnVector: CartesianCoordinateSystem = CartesianCoordinateSystem()
        
        func check(comp1: CartesianTerms, comp2: [CartesianTerms]) -> Bool {
            var isPresent: Bool = false
            
            comp2.forEach{ term in
                if term.getBases() == comp1.getBases() && term.getExponents() == term.getExponents() {
                    isPresent = true
                }
            }
            
            return isPresent
        }
        
        // loop over every component of each vector
        var added: [CartesianTerms] = []
        
        vector1.xComponent.component.forEach { component in
            vector2.xComponent.component.forEach { component2 in
                // if getBase() and getExpomnents() are equal append terms and sum of coefficient to corressponding component of returnVector
                if component.getBases() == component2.getBases() && component.getExponents() == component2.getExponents() {
                    if (Double(component.coefficient) ?? 1) - (Double(component2.coefficient) ?? 1) != Double(0) {
                        returnVector.xComponent.component.append(CartesianTerms(coefficient: String((Double(component.coefficient) ?? 1) - (Double(component2.coefficient) ?? 1)), terms: component.terms))
                    }
                } else {
                    returnVector.xComponent.component.append(CartesianTerms(coefficient: component.coefficient, terms: component.terms))
//                    returnVector.xComponent.component.append(CartesianTerms(coefficient: "-" + component2.coefficient, terms: component2.terms))
                    if !(check(comp1: component2, comp2: added)) {
                        added.append(component2)
                    }
                }
            }
        }
        
        added.forEach { term in
            returnVector.xComponent.component.append(CartesianTerms(coefficient: "+" + term.coefficient, terms: term.terms))
        }
        
        if vector1.xComponent.component.isEmpty {
//            returnVector.xComponent.component.append(contentsOf: vector2.xComponent.component)
            vector2.xComponent.component.forEach { comp in
                returnVector.xComponent.component.append(CartesianTerms(coefficient: "-" + comp.coefficient, terms: comp.terms))
            }
        }
        if vector2.xComponent.component.isEmpty {
            returnVector.xComponent.component.append(contentsOf: vector1.xComponent.component)
        }
        
        added.removeAll()
        
        vector1.yComponent.component.forEach { component in
            vector2.yComponent.component.forEach { component2 in
                // if getBase() and getExpomnents() are equal append terms and sum of coefficient to corressponding component of returnVector
                if component.getBases() == component2.getBases() && component.getExponents() == component2.getExponents() {
                    if (Double(component.coefficient) ?? 1) - (Double(component2.coefficient) ?? 1) != Double(0) {
                        returnVector.yComponent.component.append(CartesianTerms(coefficient: String((Double(component.coefficient) ?? 1) - (Double(component2.coefficient) ?? 1)), terms: component.terms))
                    }
                } else {
                    returnVector.yComponent.component.append(CartesianTerms(coefficient: component.coefficient, terms: component.terms))
//                    returnVector.yComponent.component.append(CartesianTerms(coefficient: "-" + component2.coefficient, terms: component2.terms))
                    if !(check(comp1: component2, comp2: added)) {
                        added.append(component2)
                    }
                }
            }
        }
        
        added.forEach { term in
            returnVector.xComponent.component.append(CartesianTerms(coefficient: "+" + term.coefficient, terms: term.terms))
        }
        
        if vector1.yComponent.component.isEmpty {
//            returnVector.yComponent.component.append(contentsOf: vector2.yComponent.component)
            vector2.yComponent.component.forEach { comp in
                returnVector.yComponent.component.append(CartesianTerms(coefficient: "-" + comp.coefficient, terms: comp.terms))
            }
        }
        if vector2.yComponent.component.isEmpty {
            returnVector.yComponent.component.append(contentsOf: vector1.yComponent.component)
        }
        
        added.removeAll()
        
        vector1.zComponent.component.forEach { component in
            vector2.zComponent.component.forEach { component2 in
                // if getBase() and getExpomnents() are equal append terms and sum of coefficient to corressponding component of returnVector
                if component.getBases() == component2.getBases() && component.getExponents() == component2.getExponents() {
                    if (Double(component.coefficient) ?? 1) - (Double(component2.coefficient) ?? 1) != Double(0) {
                        returnVector.zComponent.component.append(CartesianTerms(coefficient: String((Double(component.coefficient) ?? 1) - (Double(component2.coefficient) ?? 1)), terms: component.terms))
                    }
                } else {
                    returnVector.zComponent.component.append(CartesianTerms(coefficient: component.coefficient, terms: component.terms))
//                    returnVector.zComponent.component.append(CartesianTerms(coefficient: "-" + component2.coefficient, terms: component2.terms))
                    if !(check(comp1: component2, comp2: added)) {
                        added.append(component2)
                    }
                }
            }
        }
        
        added.forEach { term in
            returnVector.xComponent.component.append(CartesianTerms(coefficient: "+" + term.coefficient, terms: term.terms))
        }
        
        if vector1.zComponent.component.isEmpty {
//            returnVector.zComponent.component.append(contentsOf: vector2.zComponent.component)
            vector2.zComponent.component.forEach { comp in
                returnVector.zComponent.component.append(CartesianTerms(coefficient: "-" + comp.coefficient, terms: comp.terms))
            }
        }
        if vector2.zComponent.component.isEmpty {
            returnVector.zComponent.component.append(contentsOf: vector1.zComponent.component)
        }
        
        return returnVector
    }
    
    
    
    private func multiplication(_ component1: CartesianCoordinateComponent, _ component2: CartesianCoordinateComponent) -> CartesianCoordinateComponent {
        var returnComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
        var returnTerms: CartesianTerms = CartesianTerms()
        
        component1.component.forEach { comp in
            component2.component.forEach { comp2 in
                var i = 0
                var j = 0
                var set = 0
                var isPresent2: Bool = false
                isPresent2 = isPresentt(comp, comp2)
                var toPass = false
                debugPrint("im here " + isPresent2.description)
                print(comp)
                print(comp2)
                while(i < comp.terms.count) {
                    var isPresent: Bool = false
                    j = set
                    while(j < comp2.terms.count) {
                        if comp[i].base == comp2[j].base {
                            returnTerms.terms.append(Variable(base: comp[i].base, exponent: String((Double(comp[i].exponent) ?? 1) + (Double(comp2[j].exponent) ?? 1))))
                            isPresent = true
                            toPass = true
                            set += 1
                        } else {
                            if !toPass {
                                if !isPresent2 {
                                    returnTerms.terms.append(comp2[j])
                                    toPass = true
                                }
                            }
                        }
                        j += 1
                    }
                    if !isPresent {
                        returnTerms.terms.append(comp[i])
                    }
                    i += 1
                }
                returnTerms.coefficient = String((Double(comp.coefficient) ?? 1) * (Double(comp2.coefficient) ?? 1))
                
                returnComponent.component.append(CartesianTerms(coefficient: returnTerms.coefficient, terms: returnTerms.terms))
                returnTerms.terms.removeAll()
                
            }
        }
        
        func isPresentt(_ terms1: CartesianTerms, _ terms2: CartesianTerms) -> Bool {
            var isPresent: Bool = false
            
            terms1.terms.forEach { term in
                terms2.terms.forEach { term2 in
                    if term.base == term2.base {
                        isPresent = true
                    }
                }
            }
            
            return isPresent
        }
        
        
        // WORKING FUNCTION
        /*
        component1.component.forEach { comp in
            component2.component.forEach { comp2 in
//                var isPresent: Bool = false
                comp.terms.forEach { term in
                    var isPresent: Bool = false
                    comp2.terms.forEach { term2 in
                        if term.base == term2.base {
                            returnTerms.terms.append(Variable(base: term.base, exponent: String((Double(term.exponent) ?? 1) + (Double(term2.exponent) ?? 1))))
                            isPresent = true
                        } else {
                            returnTerms.terms.append(term2)
                            
                        }
                    }
                    if !isPresent {
                        returnTerms.terms.append(term)
                    }
                    
//                    returnTerms.coefficient = String((Double(comp.coefficient) ?? 1) * (Double(comp2.coefficient) ?? 1))
//
//                    returnComponent.component.append(CartesianTerms(coefficient: returnTerms.coefficient, terms: returnTerms.terms))
//                    returnTerms.terms.removeAll()
                }
                returnTerms.coefficient = String((Double(comp.coefficient) ?? 1) * (Double(comp2.coefficient) ?? 1))
                
                returnComponent.component.append(CartesianTerms(coefficient: returnTerms.coefficient, terms: returnTerms.terms))
                returnTerms.terms.removeAll()
            }
        }
         */
        
        return returnComponent
    }
    
    private func division(_ component1: CartesianCoordinateComponent, _ component2: CartesianCoordinateComponent) -> CartesianCoordinateComponent {
        var returnComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
        var returnTerms: CartesianTerms = CartesianTerms()
        
        component1.component.forEach { comp in
            component2.component.forEach { comp2 in
                var i = 0
                var j = 0
                var set = 0
                var isPresent2: Bool = false
                isPresent2 = isPresentt(comp, comp2)
                var toPass = false
                debugPrint("im here " + isPresent2.description)
                print(comp)
                print(comp2)
                while(i < comp.terms.count) {
                    var isPresent: Bool = false
//                    var isPresent2: Bool = false
//                    var set = 0
                    isPresent2 = isPresentt(comp, comp2)
                    j = set
                    while(j < comp2.terms.count) {
                        if comp[i].base == comp2[j].base {
                            let check = (Double(comp[i].exponent) ?? 1) - (Double(comp2[j].exponent) ?? 1)
                            if check != 0 {
                                returnTerms.terms.append(Variable(base: comp[i].base, exponent: String((Double(comp[i].exponent) ?? 1) - (Double(comp2[j].exponent) ?? 1))))
                            }
                            isPresent = true
                            toPass = true
                            set += 1
                        } else {
                            if !toPass {
                                if !isPresent2 {
                                    //                                returnTerms.terms.append(comp2[j])
                                    returnTerms.terms.append(Variable(base: comp2[j].base, exponent: "-" + comp2[j].exponent))
                                    toPass = true
                                }
                            }
                        }
                        j += 1
                    }
                    if !isPresent {
                        returnTerms.terms.append(comp[i])
                    }
//                    j = 0
                    i += 1
                }
//                returnTerms.coefficient = String((Double(comp.coefficient) ?? 1) / (Double(comp2.coefficient) ?? 1))
                // round coeeficient off to two decimal places.
                returnTerms.coefficient = String(format: "%.4f", ((Double(comp.coefficient) ?? 1) / (Double(comp2.coefficient) ?? 1)))
                
                returnComponent.component.append(CartesianTerms(coefficient: returnTerms.coefficient, terms: returnTerms.terms))
                returnTerms.terms.removeAll()
                
            }
        }
        
        func isPresentt(_ terms1: CartesianTerms, _ terms2: CartesianTerms) -> Bool {
            var isPresent: Bool = false
            
            terms1.terms.forEach { term in
                terms2.terms.forEach { term2 in
                    if term.base == term2.base {
                        isPresent = true
                    }
                }
               
            }
            
            return isPresent
        }
        
        return returnComponent
    }
    
    private func dotProduct(_ vector1: CartesianCoordinateSystem, _ vector2: CartesianCoordinateSystem) -> CartesianCoordinateSystem {
        var answer: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var xProduct: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var yProduct: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var zProduct: CartesianCoordinateSystem = CartesianCoordinateSystem()
        
        xProduct.xComponent = multiplication(vector1.xComponent, vector2.xComponent)
        yProduct.xComponent = multiplication(vector1.yComponent, vector2.yComponent)
        zProduct.xComponent = multiplication(vector1.zComponent, vector2.zComponent)
        
        // since addition vector takes a vector we create vectors witj the components and only deal with the xAxis.
        answer.xComponent = addition(xProduct, yProduct).xComponent
        debugPrint("\n" , answer.xComponent)
        answer.xComponent = addition(answer, zProduct).xComponent
        
        debugPrint("\n" , answer.xComponent)
        print("\n" , xProduct.xComponent)
        print("\n" , yProduct.xComponent)
        print("\n" , zProduct.xComponent)
        
        return answer
    }
    
    private func crossProduct(_ vector1: CartesianCoordinateSystem, _ vector2: CartesianCoordinateSystem) -> CartesianCoordinateSystem {
        var answer: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var subX: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var subY: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var subZ: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var subX2: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var subY2: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var subZ2: CartesianCoordinateSystem = CartesianCoordinateSystem()
        
        subX.xComponent = multiplication(vector1.yComponent, vector2.zComponent)
        subX2.xComponent = multiplication(vector1.zComponent, vector2.yComponent)
        
        subY.yComponent = multiplication(vector1.zComponent, vector2.xComponent)
        subY2.yComponent = multiplication(vector1.xComponent, vector2.zComponent)
        
        subZ.zComponent = multiplication(vector1.xComponent, vector2.yComponent)
        subZ2.zComponent = multiplication(vector1.yComponent, vector2.xComponent)
        
        answer.xComponent = subtraction(subX, subX2).xComponent
        answer.yComponent = subtraction(subY, subY2).yComponent
        answer.zComponent = subtraction(subZ, subZ2).zComponent
        
        return answer
    }
    
    private func magnitude(_ vector1: CartesianCoordinateSystem) -> CartesianCoordinateSystem {
        var returnVector: CartesianCoordinateSystem = CartesianCoordinateSystem()
        var subX: CartesianCoordinateSystem = CartesianCoordinateSystem()
//        var subY: CartesianCoordinateSystem = CartesianCoordinateSystem()
//        var subZ: CartesianCoordinateSystem = CartesianCoordinateSystem()
        
        var prodX: CartesianCoordinateSystem  = CartesianCoordinateSystem()
        var prodY: CartesianCoordinateSystem  = CartesianCoordinateSystem()
        var prodZ: CartesianCoordinateSystem  = CartesianCoordinateSystem()
        
        subX = subtraction(vector1, vector2)
//        subY.yComponent = subtraction(vector1, vector2).yComponent
//        subZ.zComponent = subtraction(vector1, vector2).zComponent
        
        prodX.xComponent = multiplication(subX.xComponent, subX.xComponent)
        prodY.xComponent = multiplication(subX.yComponent, subX.yComponent)
        prodZ.xComponent = multiplication(subX.zComponent, subX.zComponent)
        
        
        returnVector = addition(prodX, prodY)
        returnVector = addition(returnVector, prodZ)
        
        returnVector.xComponent = squareRoot(returnVector.xComponent)
        
        return returnVector
    }
    
    private func squareRoot(_ component: CartesianCoordinateComponent) -> CartesianCoordinateComponent {
        var root: CartesianCoordinateComponent = CartesianCoordinateComponent()
        
        component.component.forEach { comp in
            var rootTerms: [Variable] = []
            comp.terms.forEach { term in
                rootTerms.append(Variable(base: term.base, exponent: String((Double(term.exponent) ?? 1) / 2)))
            }
            root.component.append(CartesianTerms(coefficient: String(format: "%.4f", sqrt(Double(comp.coefficient) ?? 1)), terms: rootTerms))
//            root.component.append(CartesianTerms(coefficient: String(sqrt(Double(comp.coefficient) ?? 1)), terms: rootTerms))
        }
        
        return root
    }
    
    private func unitVector(_ vector1: CartesianCoordinateSystem) -> CartesianCoordinateSystem {
        var returnVector: CartesianCoordinateSystem = CartesianCoordinateSystem()
        let magnitude = magnitude(vector1).xComponent
        
        returnVector.xComponent = division(vector1.xComponent, magnitude)
        returnVector.yComponent = division(vector1.yComponent, magnitude)
        returnVector.zComponent = division(vector1.zComponent, magnitude)
        
        
        return returnVector
    }
    
    private func curl(_ xComponent: CartesianCoordinateComponent,_ yComponent: CartesianCoordinateComponent,_ zComponent: CartesianCoordinateComponent) -> CartesianCoordinateSystem {
        var answer: CartesianCoordinateSystem = CartesianCoordinateSystem()
        let x1 = differentiateComponent(base: "y", component: zComponent)
        let x2 = differentiateComponent(base: "z", component: yComponent)
        let y1 = differentiateComponent(base: "z", component: xComponent)
        let y2 = differentiateComponent(base: "x", component: zComponent)
        let z1 = differentiateComponent(base: "x", component: yComponent)
        let z2 = differentiateComponent(base: "y", component: xComponent)
        
        
//        let answerX = subtraction(x1, x2)
//        let answerY = subtraction(y1, y2)
//        let answerZ = subtraction(z1, z2)
        answer.xComponent = subtraction(x1, x2).xComponent
        print(subtraction(x1, x2).xComponent)
        answer.yComponent = subtraction(y1, y2).xComponent
        print(subtraction(y1, y2).xComponent)
        answer.zComponent = subtraction(z1, z2).xComponent
        print(subtraction(z1, z2).xComponent)
        print(answer)
        return answer
    }
    
    private func divergence(_ vector: CartesianCoordinateSystem) -> CartesianCoordinateSystem {
        var answer: CartesianCoordinateSystem = CartesianCoordinateSystem()
        
        answer.xComponent = differentiateComponent(base: "x", component: vector.xComponent).xComponent
        answer.yComponent = differentiateComponent(base: "y", component: vector.yComponent).xComponent
        answer.zComponent = differentiateComponent(base: "z", component: vector.zComponent).xComponent
        
        return answer
    }
    
    private func gradient(_ function: CartesianCoordinateComponent) -> CartesianCoordinateSystem {
        var answer: CartesianCoordinateSystem = CartesianCoordinateSystem()
        
        answer.xComponent = differentiateComponent(base: "x", component: function).xComponent
        answer.yComponent = differentiateComponent(base: "y", component: function).xComponent
        answer.zComponent = differentiateComponent(base: "z", component: function).xComponent
        
        return answer
    }
    
    private func differentiateComponent(base: String, component: CartesianCoordinateComponent) -> CartesianCoordinateSystem {
        var returnComponent: CartesianCoordinateComponent = CartesianCoordinateComponent()
        var returnVector: CartesianCoordinateSystem = CartesianCoordinateSystem()
        
        component.component.forEach { comp in
            let tempCoefficient = differentiate(base: base, coefficient: comp.coefficient, component: comp.terms).0
            let tempTerm = differentiate(base: base, coefficient: comp.coefficient, component: comp.terms).1
            print(comp.coefficient)
            
            returnComponent.component.append(CartesianTerms(coefficient: tempCoefficient, terms: tempTerm))
        }
        print(returnComponent)
        returnVector.xComponent = returnComponent
        return returnVector
    }
    
    private func differentiate(base: String, coefficient: String, component: [Variable])-> (String, [Variable]) {
        var returnCoefficient: String = "0"
        var returnComponent: [Variable] = []
        var mustReturn: [Variable] = []
        var a: Bool = false
        
        component.forEach { term in
            if term.base == base {
                if (Double(term.exponent) ?? 1) - 1 != 0 {
                    mustReturn.append(Variable(base: base, exponent: String((Double(term.exponent) ?? 1) - 1)))
                }
//                else {
//                    mustReturn.append(Variable(base: "1", exponent: "0"))
//                }
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
//            mustReturn.append(Variable(base: "1", exponent: "0"))
        }
        
        returnComponent = mustReturn
        
        return (returnCoefficient, returnComponent)
    }
}

struct SignButton: View {
    @Binding var axis: CartesianCoordinateComponent
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var exponents: Bool
    
    var sign: String
    
    var body: some View {
        Button {
//            if component.coefficient.count == 1 {
//                if component.coefficient == "+" || component.coefficient == "-" {
//                    component.coefficient.removeAll()
//                }
//            }
            
            if !exponents {
                if !variable.base.isEmpty {
                    if !variable.exponent.isEmpty {
                        component.terms.append(Variable(base: variable.base, exponent: variable.exponent))
                    } else {
                        component.terms.append(Variable(base: variable.base, exponent: "1"))
                    }
                }
                
                if component.coefficient.isEmpty {
                    if !component.terms.isEmpty {
                        axis.component.append(CartesianTerms(coefficient: "1", terms: component.terms))
                    }
                } else {
                    if !component.terms.isEmpty {
                        axis.component.append(CartesianTerms(coefficient: component.coefficient, terms: component.terms))
                    } else {
                        axis.component.append(CartesianTerms(coefficient: component.coefficient))
                    }
                }
                
                variable = Variable()
                component.coefficient.removeAll()
                component.terms.removeAll()
                
                if component.coefficient.isEmpty {
                    component.coefficient.append(sign)
                }
            } else {
                
            }
            
        } label: {
            Text(sign)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(.black))
        }
    }
}

struct SignSelector: View {
    @Binding var axis: CartesianCoordinateComponent
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @State var currentSign: String = "+"
    @Binding var exponents: Bool
    
    var body: some View {
        HStack {
            SignButton(axis: $axis, component: $component, variable: $variable, exponents: $exponents, sign: "+")
            SignButton(axis: $axis, component: $component, variable: $variable, exponents: $exponents, sign: "-")
        }
    }
}

struct MyText: View {
    @Binding var axis: CartesianCoordinateComponent
    
    var body: some View {
        HStack(alignment: .top, spacing: 1) {
            if axis.component.isEmpty {
                Text("0")
            }
            ForEach(axis.component) { term in
                if term.coefficient != "0" {
                    if term.coefficient != "-1" {
                        //                    Text(term.coefficient == "1" || term.coefficient == "+1" ? "" : term.coefficient)
                        if term.coefficient != "+1" {
                            Text(term.coefficient == "1" ? "" : term.coefficient)
                        } else {
                            Text("+")
                        }
                    } else {
                        Text("-")
                    }
                    if term.terms.isEmpty {
                        if term.coefficient == "1" {
                            Text("1")
                        }
                    }
                }
                ForEach(term.terms) { variable in
                    Text(variable.base)
                    Text(variable.exponent == "1" ? "" : variable.exponent)
                        .font(.caption2)
                }
            }
        }
        .frame(minWidth: 10)
    }
}

struct MyVectorTextField: View {
    @Binding var vector: CartesianCoordinateSystem
    @Binding var receiveComponents: Bool
    @State var title: String
    @Binding var currentVector: Int
    var setTo: Int
    @Binding var myColor: String
    @Binding var borderColor: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
                .padding(.leading)
            
            Button {
                currentVector = setTo
                withAnimation(.easeInOut) {
                    receiveComponents = true
                }
            } label: {
                HStack(spacing: 2) {
                    MyText(axis: $vector.xComponent)
                    Text("i")
                        Text("+")
                    MyText(axis: $vector.yComponent)
                    Text("j")
                        Text("+")
                    MyText(axis: $vector.zComponent)
                    Text("k")
                }
                .foregroundColor(.black)
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(myColor).opacity(0.5)))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2).foregroundColor(Color(borderColor)))
            }
        }
    }
}

struct OperationPicker: View {
    @Binding var operation: VectorOperation
    
    var body: some View {
        HStack {
            Spacer(minLength: UIScreen.main.bounds.width / 2.9)
            Picker("Operation", selection: $operation) {
                Text("addition").tag(VectorOperation.addition)
                Text("subtraction").tag(VectorOperation.subtraction)
                Text("dot product").tag(VectorOperation.dotProduct)
                Text("cross product").tag(VectorOperation.crossProduct)
                Text("scalar multiplication").tag(VectorOperation.scalarMultiplication)
                Text("unit vector").tag(VectorOperation.unitVector)
                Text("magnitude").tag(VectorOperation.magnitude)
                Text("curl").tag(VectorOperation.curl)
                Text("divergence").tag(VectorOperation.divergence)
                Text("gradient").tag(VectorOperation.gradient)
            }
        }
    }
}

struct ComponentSelectorRow: View {
    @Binding var axis: CartesianCoordinateComponent
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var currentComponent: String
    
    var body: some View {
        HStack {
            ComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "i", currentComponent: $currentComponent)
            ComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "j", currentComponent: $currentComponent)
            ComponentSelector(axis: $axis, component: $component, variable: $variable,componentAxis: "k", currentComponent: $currentComponent)
        }
    }
}

struct ComponentSelector: View {
    @Binding var axis: CartesianCoordinateComponent
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @State var componentAxis: String
    @Binding var currentComponent: String
    
    var body: some View {
        HStack {
            Button {
                if !variable.base.isEmpty {
                    if !variable.exponent.isEmpty {
                        component.terms.append(Variable(base: variable.base, exponent: variable.exponent))
                    } else {
                        component.terms.append(Variable(base: variable.base, exponent: "1"))
                    }
                }
                
                if component.coefficient.isEmpty {
                    if !component.terms.isEmpty {
                        axis.component.append(CartesianTerms(coefficient: "1", terms: component.terms))
                    }
                } else {
                    if !component.terms.isEmpty {
                        axis.component.append(CartesianTerms(coefficient: component.coefficient, terms: component.terms))
                    } else {
                        axis.component.append(CartesianTerms(coefficient: component.coefficient))
                    }
                }
                
                variable = Variable()
                component.coefficient.removeAll()
                component.terms.removeAll()
                
                currentComponent = componentAxis
            } label: {
                Text(componentAxis.lowercased())
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 4)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 40)
                        .foregroundColor(.black.opacity( componentAxis == currentComponent ? 1 : 0.5)))
            }
        }
    }
}

// MARK: Constant Keyboard

struct ConstantExponentButton: View {
    @Binding var exponents: Bool
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {
                    exponents.toggle()
                }
            } label: {
                if exponents {
                    Text(String("12..."))
//                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 3.2)
                        .background(RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(myColor).opacity(0.3)))
                }
                else {
                    HStack(alignment: .top, spacing: 0) {
                        Image(systemName: "ellipsis.rectangle.fill")
                            .font(.title)
                        Text(String("?"))
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 3.2)
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(myColor).opacity(0.3)))
                }
            }
        }
    }
}

struct VectorKeyBoardConstants: View {
    @Binding var exponents: Bool
    @Binding var coefficient: String
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            VectorKeyRowConstants(start: 1, end: 3, coefficient: $coefficient, myColor: $myColor)
            VectorKeyRowConstants(start: 4, end: 6, coefficient: $coefficient, myColor: $myColor)
            VectorKeyRowConstants(start: 7, end: 9, coefficient: $coefficient, myColor: $myColor)
            HStack {
                ConstantExponentButton(exponents: $exponents, myColor: $mySolveColor)
                VectorKeyRowConstants(start: 0, end: 0, coefficient: $coefficient, myColor: $myColor)
                VectorKeyConstantsSpecial(key: ".", component: $coefficient, myColor: $mySolveColor)
            }
        }
    }
}

struct VectorKeyRowConstants: View {
    @State var start: Int
    @State var end: Int
    @Binding var coefficient: String
    @Binding var myColor: String
    
    var body: some View {
        HStack {
            ForEach(start..<end + 1, id: \.self) { item in
                VectorKeyConstants(key: item, coefficient: $coefficient, myColor: $myColor)
            }
        }
    }
}

struct VectorKeyConstants: View {
    @State var key: Int
    @Binding var coefficient: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            Button {
                coefficient.append(String(key))
            } label: {
                Text(String(key))
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 3.2)
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(myColor).opacity(0.3)))
            }
        }
    }
}

struct VectorKeyConstantsSpecial: View {
    @State var key: String
    @Binding var component: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            Button {
                component.append(String(key))
            } label: {
                Text(String(key))
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 3.2)
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(myColor).opacity(0.3)))
            }
        }
    }
}

// MARK: Exponent Keyboard

struct VectorKeyBoardExponents: View {
    @Binding var exponents: Bool
    @Binding var exponent: String
    @Binding var variable: Variable
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            VectorKeyRowExponents(start: 1, end: 3,variable: $variable, exponent: $exponent, myColor: $myColor)
            VectorKeyRowExponents(start: 4, end: 6,variable: $variable, exponent: $exponent, myColor: $myColor)
            VectorKeyRowExponents(start: 7, end: 9,variable: $variable, exponent: $exponent, myColor: $myColor)
            HStack {
                ConstantExponentButton(exponents: $exponents, myColor: $mySolveColor)
                VectorKeyRowExponents(start: 0, end: 0, variable: $variable, exponent: $exponent, myColor: $myColor)
                VectorKeyConstantsSpecial(key: ".", component: $exponent, myColor: $mySolveColor)
            }
        }
    }
}

struct VectorKeyRowExponents: View {
    @State var start: Int
    @State var end: Int
    @Binding var variable: Variable
    @Binding var exponent: String
    @Binding var myColor: String
    
    var body: some View {
        HStack {
            ForEach(start..<end + 1, id: \.self) { item in
                VectorKeyExponents(key: item, variable: $variable, exponent: $exponent, myColor: $myColor)
            }
        }
    }
}

struct VectorKeyExponents: View {
    @State var key: Int
    @Binding var variable: Variable
    @Binding var exponent: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            Button {
                if !variable.base.isEmpty {
                    exponent = variable.exponent
                    exponent += String(key)
                    variable = Variable(base: variable.base, exponent: exponent)
                    exponent.removeAll()
                }
            } label: {
                HStack(alignment: .top, spacing: 0) {
                    Image(systemName: "ellipsis.rectangle.fill")
                        .font(.system(size: 41))
                        .opacity(0.3)
                    Text(String("_"))
                        .font(.caption)
                        .fontWeight(.bold)
                    Text(String(key))
                        .font(.caption)
                        .fontWeight(.bold)
                }
                .foregroundColor(.black)
                .padding()
                .frame(width: UIScreen.main.bounds.width / 3.2)
                .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(myColor).opacity(0.3)))
            }
        }
    }
}

struct VectorKeyBoard: View {
    @State var exponents: Bool = false
    @State var exponent: String = ""
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    
    var body: some View {
        VStack {
            if exponents {
                VectorKeyBoardExponents(exponents: $exponents, exponent: $exponent, variable: $variable, mySolveColor: $mySolveColor, myColor: $myColor)
            } else {
                VectorKeyBoardConstants(exponents: $exponents, coefficient: $component.coefficient, mySolveColor: $mySolveColor, myColor: $myColor)
            }
        }
    }
}

// MARK: Variable Keyboard

struct VectorKeyVariable: View {
    @State var variableText: String
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    let label: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            Button {
                if component.coefficient == "-" {
                    component.coefficient.append("1")
                
                }
                if component.coefficient == "+" {
                    component.coefficient.append("1")
                
                }
                if !variable.base.isEmpty {
                    if variable.base.last == ")" {
                        var temp = variable.base
                        temp.removeLast()
                        temp = temp + variableText + ")"
                        variableText = temp
                        
                        variable = Variable()
//                        variable.base.append(variableText + ")")
                    }
                    if variable.exponent.isEmpty {
                        component.terms.append(Variable(base: variable.base, exponent: "1"))
                    } else {
//                        if component.coefficient == "-" {
//                            component.coefficient.append("1")
//
//                        }
                        component.terms.append(variable)
                        variable.exponent.removeAll()
                    }
                }
                
                variable.base.removeAll()
//                variable.base.append(variableText)
                variable = Variable(base: variableText, exponent: "")
            } label: {
                Text(String(label))
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 3.2)
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(myColor).opacity(0.3)))
            }
        }
    }
}

struct VectorKeyRowVariables: View {
    @State var start: Int
    @State var end: Int
    var variableTexts: [String]
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var myColor: String
    
    var body: some View {
        HStack {
            ForEach(start..<end, id: \.self) { item in
                VectorKeyVariable(variableText: variableTexts[item], component: $component, variable: $variable, label: variableTexts[item], myColor: $myColor)
            }
        }
    }
}

struct VectorKeyBoardVariables: View {
    let variableTexts: [String] = ["x", "y", "z", "a", "b", "c", "r", "θ", "u"]
    @Binding var exponents: Bool
    @State var coefficient: String = ""
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var trignometry: Bool
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            VectorKeyRowVariables(start: 0, end: 3, variableTexts: variableTexts, component: $component, variable: $variable, myColor: $myColor)
            VectorKeyRowVariables(start: 3, end: 6, variableTexts: variableTexts, component: $component, variable: $variable, myColor: $myColor)
            VectorKeyRowVariables(start: 6, end: 9, variableTexts: variableTexts, component: $component, variable: $variable, myColor: $myColor)
            HStack {
//                ConstantExponentButton(exponents: $exponents)
                TrigConstantButton(trignometry: $trignometry, mySolveColor: $mySolveColor)
                VectorKeyRowConstants(start: 0, end: 0, coefficient: $coefficient, myColor: $myColor)
                VectorKeyConstantsSpecial(key: ".", component: $coefficient, myColor: $mySolveColor)
            }
        }
    }
}

struct VariableConstantButton: View {
    var title: String
    @Binding var variables: Bool
    @Binding var mySolveColor: String
    
    var body: some View {
        Button{
            withAnimation(.easeInOut) {
                variables.toggle()
            }
        } label: {
            Text(title)
                .foregroundColor(.black)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(mySolveColor).opacity(0.3)))
        }
    }
}


