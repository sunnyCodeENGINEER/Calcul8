//
//  CylindricalCoordinateView.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 23/12/2022.
//

import SwiftUI

struct CylindricalCoordinateView: View {
    @Binding var coordinateSystem: CoordinateSystem
    @Binding var myColor: String
    @Binding var mySolveColor: String
    
    @State private var vector1: SphericalCoordinateSystem = SphericalCoordinateSystem()
    @State private var vector2: SphericalCoordinateSystem = SphericalCoordinateSystem()
    @State private var answerVector: SphericalCoordinateSystem = SphericalCoordinateSystem()
    
    @State var term: SphericalTerms = SphericalTerms()
    @State private var component: CartesianTerms = CartesianTerms()
    @State private var sphericalComponent: SphericalComponent = SphericalComponent()
    @State private var components: [CartesianTerms] = []
    @State private var variable: Variable = Variable()
    @State private var operation: VectorOperation = .addition
    @State private var currentComponent: String = "r"
    @State private var coefficient: String = ""
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
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .padding(.top)
                    }
                    .tint(Color(mySolveColor))
                    .padding(.leading)
                    
                    Spacer()
                }
                
                Spacer()
                
                if operation != .gradient {
                    VStack {
                        SphericalVectorTextField(vector: $vector1, receiveComponents: $recieveComponents, title: "vector 1", currentVector: $currentVector, setTo: 1, title1: "r", title2: "θ", title3: "z", myColor: $myColor, borderColor: $mySolveColor)
                        CylindricalDoneButtonDecider(vector: $vector1, term: $term, component: $component, variable: $variable, currentComponent: $currentComponent, sphericalComponent: $sphericalComponent)
                            .tint(Color(mySolveColor))
                        SphericalOperationPicker(operation: $operation)
                            .tint(Color(mySolveColor))
                        if operation != .curl && operation != .divergence {
                            SphericalVectorTextField(vector: $vector2, receiveComponents: $recieveComponents, title: "vector 2", currentVector: $currentVector, setTo: 2, title1: "r", title2: "θ", title3: "z", myColor: $myColor, borderColor: $mySolveColor)
                            CylindricalDoneButtonDecider(vector: $vector2, term: $term, component: $component, variable: $variable, currentComponent: $currentComponent, sphericalComponent: $sphericalComponent)
                                .tint(Color(mySolveColor))
                        }
                        MyCylindricalSolveButton(vector1: $vector1, vector2: $vector2, answerVector: $answerVector, receiveComponent: $recieveComponents, showAnser: $showAnswer, operation: $operation, myColor: $mySolveColor)
                    }
                } else {
                    SphericalFunctionField(function: $vector1.xComponent, receiveComponents: $recieveComponents, myColor: $myColor, borderColor: $mySolveColor)
                    SphericalOperationPicker(operation: $operation)
                        .tint(Color(mySolveColor))
                    HStack {
                        SphericalClearButton(axis: $vector1.xComponent, term: $term, component: $component)
                            .tint(Color(mySolveColor))
                        SphericalDoneButton(axis: $vector1.xComponent, term: $term, component: $component, variable: $variable, currentComponent: $currentComponent, sphericalComponent: $sphericalComponent)
                            .tint(Color(mySolveColor))
                    }
                    MyCylindricalSolveButton(vector1: $vector1, vector2: $vector2, answerVector: $answerVector, receiveComponent: $recieveComponents, showAnser: $showAnswer, operation: $operation, myColor: $mySolveColor)
                }
                if showAnswer {
                    SphericalAnswerBoard(answerVector: $answerVector, title1: "r", title2: "θ", title3: "z")
                }
                VStack {
                    if recieveComponents {
                        VStack {
                            if operation != .gradient {
                                VStack {
                                    CylindricalComponentSelectorDecider(vector1: $vector1, vector2: $vector2, component: $component, variable: $variable, currentComponent: $currentComponent, currentVector: $currentVector, term: $term, sphericalComponent: $sphericalComponent)
                                }
                            }
                            HStack {
                                VariableConstantButton(title: variables ? "Conatants" : "Variables", variables: $variables, mySolveColor: $mySolveColor)
                                
                                CylindricalComponentSignDecider(vector1: $vector1, vector2: $vector2, component: $component, variable: $variable, currentComponent: $currentComponent, currentVector: $currentVector, exponents: $exponents, term: $term, sphericalComponent: $sphericalComponent)
                            }
                            if !variables {
                                CylindricalVectorKeyBoard(component: $component, variable: $variable, mySolveColor: $mySolveColor, myColor: $myColor)
                            } else {
                                CylindricalKeyboardDecider(vector1: $vector1, vector2: $vector2, components: $components, exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $vector1.xComponent, sphericalComponent: $sphericalComponent, currentComponent: $currentComponent, currentVector: $currentVector, mySolveColor: $mySolveColor, myColor: $myColor)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .background(RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color("white"))
                            .shadow(radius: 10, y: -10)
                            .ignoresSafeArea())
                    }
                }
                .keyboardRespectSafeArea()
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
        }
    }
}

struct CylindricalCoordinateView_Previews: PreviewProvider {
    static var previews: some View {
        CylindricalCoordinateView(coordinateSystem: .constant(.cylindrical), myColor: .constant(""), mySolveColor: .constant(""))
    }
}

struct MyCylindricalSolveButton: View {
    @Binding var vector1: SphericalCoordinateSystem
    @Binding var vector2: SphericalCoordinateSystem
    @Binding var answerVector: SphericalCoordinateSystem
    @Binding var receiveComponent: Bool
    @Binding var showAnser: Bool
    @Binding var operation: VectorOperation
    @Binding var myColor: String
    
    // constants
    
    let r = SphericalCoordinateSystem(xComponent: SphericalCoordinateComponent(component: [SphericalTerms(trigCoefficient: [CartesianTerms(coefficient: "1", terms: [Variable(base: "r", exponent: "1")])])]), yComponent: SphericalCoordinateComponent(), zComponent: SphericalCoordinateComponent())
   
    var body: some View {
        HStack {
            Spacer()
            Button {
                solve()
                
                receiveComponent = false
                showAnser = true
            } label: {
                Text("Solve")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("solve"))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(myColor))
                        .blur(radius: 1)
                        .shadow(color: .black, radius: 10, x: 3, y: 5))
                    .padding()
            }
        }
    }
    func solve() {
        switch operation {
        case .addition:
            answerVector = addition(vector1, vector2)
            break
        case .subtraction:
            answerVector = subtraction(vector1, vector2)
            break
        case .dotProduct:
            break
        case .crossProduct:
            break
        case .scalarMultiplication:
            break
        case .unitVector:
            break
        case .magnitude:
            break
        case .curl:
            answerVector = curl(vector1)
            break
        case .divergence:
            answerVector = divergence(vector1)
            break
        case .gradient:
            answerVector = gradient(vector1)
            break
        }
    }
    
    private func addition(_ vector1: SphericalCoordinateSystem, _ vector2: SphericalCoordinateSystem) -> SphericalCoordinateSystem {
        var returnVector: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        func check(comp1: SphericalTerms, comp2: [SphericalTerms]) -> Bool {
            var isPresent: Bool = false
            
            comp2.forEach { term in
                if term.getComponentPersonality() == comp1.getComponentPersonality() {
                    isPresent = true
                }
            }
            
            return isPresent
        }
        
        returnVector.xComponent = addComponents(vector1.xComponent, vector2.xComponent)
        returnVector.yComponent = addComponents(vector1.yComponent, vector2.yComponent)
        returnVector.zComponent = addComponents(vector1.zComponent, vector2.zComponent)
        
        
        func addComponents(_ firstComponent: SphericalCoordinateComponent, _ secondComponent: SphericalCoordinateComponent) -> SphericalCoordinateComponent {
            var added: [SphericalTerms] = []
            var added1: [SphericalTerms] = []
            var answer: SphericalCoordinateComponent = SphericalCoordinateComponent()
            
            firstComponent.component.forEach { component in
                var isAdded1: Bool = false
                secondComponent.component.forEach { component2 in
                    var ret: [CartesianTerms] = []
                    if component.getComponentPersonality() == component2.getComponentPersonality() {
                        var isZero: Bool = false
                        component.trigCoefficient.forEach { term in
                            component2.trigCoefficient.forEach { term2 in
                                ret.append(CartesianTerms(coefficient: String((Double(term.coefficient) ?? 1) + (Double(term2.coefficient) ?? 1)), terms: term.terms))
                                if (Double(term.coefficient) ?? 1) + (Double(term2.coefficient) ?? 1) == 0 {
                                    isZero = true
                                }
                            }
                        }
                        if !isZero {
                            answer.component.append(SphericalTerms(trigCoefficient: ret, component: component.component))
                        }
                        isAdded1 = true
                        
                    } else {
                        if !(check(comp1: component, comp2: added1)) {
                            if !isAdded1 {
                                added1.append(component)
                            }
                        }
                        
                        if !(check(comp1: component2, comp2: added)) {
                            added.append(component2)
                        }
                    }
                }
            }
            added1.forEach { term in
                answer.component.append(SphericalTerms(trigCoefficient: term.trigCoefficient, component: term.component))
            }
            
            added.forEach { term in
                var ret: [CartesianTerms] = []
                term.trigCoefficient.forEach { coefficient in
                    ret.append(CartesianTerms(coefficient: "+" + coefficient.coefficient, terms: coefficient.terms))
                }
                
                answer.component.append(SphericalTerms(trigCoefficient: ret, component: term.component))
            }
            if secondComponent.component.isEmpty {
                answer.component.append(contentsOf: firstComponent.component)
            }
            if firstComponent.component.isEmpty {
                answer.component.append(contentsOf: secondComponent.component)
            }
            
            added.removeAll()
            
            return answer
        }
        
        return returnVector
    }
    
    private func subtraction(_ vector1: SphericalCoordinateSystem, _ vector2: SphericalCoordinateSystem) -> SphericalCoordinateSystem {
        var returnVector: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        func check(comp1: SphericalTerms, comp2: [SphericalTerms]) -> Bool {
            var isPresent: Bool = false
            
            comp2.forEach { term in
                if term.getComponentPersonality() == comp1.getComponentPersonality() {
                    isPresent = true
                }
            }
            
            return isPresent
        }
        
        returnVector.xComponent = subtractComponents(vector1.xComponent, vector2.xComponent)
        returnVector.yComponent = subtractComponents(vector1.yComponent, vector2.yComponent)
        returnVector.zComponent = subtractComponents(vector1.zComponent, vector2.zComponent)
        
        
        func subtractComponents(_ firstComponent: SphericalCoordinateComponent, _ secondComponent: SphericalCoordinateComponent) -> SphericalCoordinateComponent {
            var added: [SphericalTerms] = []
            var added1: [SphericalTerms] = []
            var answer: SphericalCoordinateComponent = SphericalCoordinateComponent()
            
            
            
            firstComponent.component.forEach { component in
                var isAdded1: Bool = false
                secondComponent.component.forEach { component2 in
                    var ret: [CartesianTerms] = []
                    if component.getComponentPersonality() == component2.getComponentPersonality() {
                        var isZero: Bool = false
                        component.trigCoefficient.forEach { term in
                            component2.trigCoefficient.forEach { term2 in
                                ret.append(CartesianTerms(coefficient: String((Double(term.coefficient) ?? 1) - (Double(term2.coefficient) ?? 1)), terms: term.terms))
                                if (Double(term.coefficient) ?? 1) - (Double(term2.coefficient) ?? 1) == 0 {
                                    isZero = true
                                }
                            }
                        }
                        if !isZero {
                            answer.component.append(SphericalTerms(trigCoefficient: ret, component: component.component))
                        }
                        
                            isAdded1 = true
                        
                    } else {
                        if !(check(comp1: component2, comp2: added)) {
                            added.append(component2)
                        }
                        
                        if !(check(comp1: component, comp2: added1)) {
                            if !isAdded1 {
                                added1.append(component)
                            }
                        }
                    }
                }
            }
            added1.forEach { term in
                answer.component.append(SphericalTerms(trigCoefficient: term.trigCoefficient, component: term.component))
            }
            
            added.forEach { term in
                var ret: [CartesianTerms] = []
                term.trigCoefficient.forEach { coefficient in
                    ret.append(CartesianTerms(coefficient: "-" + coefficient.coefficient, terms: coefficient.terms))
                }
                
                answer.component.append(SphericalTerms(trigCoefficient: ret, component: term.component))
            }
            if secondComponent.component.isEmpty {
                answer.component.append(contentsOf: firstComponent.component)
            }
            
            if firstComponent.component.isEmpty {
//                var ret: [CartesianTerms] = []
                secondComponent.component.forEach { term in
                    var ret: [CartesianTerms] = []
                    term.trigCoefficient.forEach { coefficient in
                        ret.append(CartesianTerms(coefficient: "-" + coefficient.coefficient, terms: coefficient.terms))
                    }
                    answer.component.append(SphericalTerms(trigCoefficient: ret, component: term.component))
                    
                }
            }
            
            added.removeAll()
            added1.removeAll()
            
            return answer
        }
        
        return returnVector
    }
    
    private func multiplication(_ component1: [CartesianTerms], _ component2: [CartesianTerms]) -> [CartesianTerms] {
        var returnComponent: [CartesianTerms] = []
        var secondComponent: [CartesianTerms] = component2
        var firstComponent: [CartesianTerms] = component1
        var returnTerms: CartesianTerms = CartesianTerms()
        
        var i = 0
        
        while (i < firstComponent.count) {
            var j = 0
            while (j < secondComponent.count) {
                var k = 0
                while (k < firstComponent[i].terms.count) {
                    var p = 0
                    while (p < secondComponent[j].terms.count) {
                        if firstComponent[i].terms[k].base == secondComponent[j].terms[p].base {
                            returnTerms.terms.append(Variable(base: firstComponent[i].terms[k].base,
                                                              exponent: String((Double(firstComponent[i].terms[k].exponent) ?? 1) + (Double(secondComponent[j].terms[p].exponent) ?? 1))))
                            firstComponent[i].terms.remove(at: k)
                            secondComponent[j].terms.remove(at: p)
                            
                            k = 0
                            p = -1
                        }
                        p += 1
                    }
                    k += 1
                }
                
                returnTerms.terms.append(contentsOf: firstComponent[i].terms)
                returnTerms.terms.append(contentsOf: secondComponent[j].terms)
                
                
                returnTerms.coefficient = String((Double(firstComponent[i].coefficient) ?? 1) * (Double(secondComponent[j].coefficient) ?? 1))
                returnComponent.append(CartesianTerms(coefficient: returnTerms.coefficient, terms: returnTerms.terms))
                
                j += 1
            }
            
            i += 1
        }
        
        
        
        return returnComponent
    }
     
    private func division(_ component1: [CartesianTerms], _ component2: [CartesianTerms]) -> [CartesianTerms] {
        var returnComponent: [CartesianTerms] = []
        var secondComponent: [CartesianTerms] = component2
        var firstComponent: [CartesianTerms] = component1
        var returnTerms: CartesianTerms = CartesianTerms()
        
        var i = 0
        
        while (i < firstComponent.count) {
            var j = 0
            while (j < secondComponent.count) {
                var k = 0
                while (k < firstComponent[i].terms.count) {
                    var p = 0
                    while (p < secondComponent[j].terms.count) {
                        if firstComponent[i].terms[k].base == secondComponent[j].terms[p].base {
                            if ((Double(firstComponent[i].terms[k].exponent) ?? 1) - (Double(secondComponent[j].terms[p].exponent) ?? 1)) != 0 {
                                returnTerms.terms.append(Variable(base: firstComponent[i].terms[k].base,
                                                                  exponent: String((Double(firstComponent[i].terms[k].exponent) ?? 1) - (Double(secondComponent[j].terms[p].exponent) ?? 1))))
                            }
                            firstComponent[i].terms.remove(at: k)
                            secondComponent[j].terms.remove(at: p)
                            
                            k = 0
                            p = -1
                        }
                        p += 1
                    }
                    k += 1
                }
                
                returnTerms.terms.append(contentsOf: firstComponent[i].terms)
                secondComponent[j].terms.forEach { variable in
                    returnTerms.terms.append(Variable(base: variable.base, exponent: String((Double(variable.exponent) ?? 1) * -1)))
                }
                
                
                returnTerms.coefficient = String((Double(firstComponent[i].coefficient) ?? 1) / (Double(secondComponent[j].coefficient) ?? 1))
                returnComponent.append(CartesianTerms(coefficient: returnTerms.coefficient, terms: returnTerms.terms))
                
                j += 1
            }
            
            i += 1
        }
        
        
        
        return returnComponent
    }
    
    private func multiplyVector(_ vector: SphericalCoordinateSystem, _ multplyBy: SphericalCoordinateSystem) -> SphericalCoordinateSystem {
        var returnVector: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        returnVector.xComponent = multiplyVectors(vector.xComponent, multplyBy.xComponent)
        returnVector.yComponent = multiplyVectors(vector.yComponent, multplyBy.yComponent)
        returnVector.zComponent = multiplyVectors(vector.zComponent, multplyBy.zComponent)
        
        func multiplyVectors(_ component1: SphericalCoordinateComponent, _ component2: SphericalCoordinateComponent) -> SphericalCoordinateComponent {
            var result: SphericalCoordinateComponent = SphericalCoordinateComponent()
            var resultTerm: SphericalTerms = SphericalTerms()
            var resultComponent: SphericalComponent = SphericalComponent()
            var firstComponent = component1
            var secondComponent = component2
            
            var coefficientResult: [CartesianTerms] = []
//            var componentResult: [CartesianTerms] = []
            var trigIDResult: String = ""
            
            var start: Bool = true
            if component1.component.count == 1 {
                if component1.component[0].component.isEmpty && component1.component[0].trigCoefficient.isEmpty {
                    start = false
                }
            }
            if component2.component.count == 1 {
                if component2.component[0].component.isEmpty && component2.component[0].trigCoefficient.isEmpty {
                    start = false
                }
            }
            
            var i = 0
            if start {
                while (i < firstComponent.component.count) {
                    if !firstComponent.component[i].component.isEmpty || !firstComponent.component[i].trigCoefficient.isEmpty {
                        var j = 0
                        while (j < secondComponent.component.count) {
                            coefficientResult = multiplication(firstComponent.component[i].trigCoefficient, secondComponent.component[j].trigCoefficient)
                            resultTerm.trigCoefficient = coefficientResult
                            
                            var k = 0
                            while (k < firstComponent.component[i].component.count) {
                                var p = 0
                                while (p < secondComponent.component[j].component.count) {
                                    if firstComponent.component[i].component[k].getBases() == secondComponent.component[j].component[p].getBases() {
                                        trigIDResult = multiplyTriID(firstComponent.component[i].component[k].trigID, secondComponent.component[j].component[p].trigID)
                                        resultComponent = SphericalComponent(trigID: trigIDResult, component: firstComponent.component[i].component[k].component)
                                        resultTerm.component.append(resultComponent)
                                        resultComponent = SphericalComponent()
                                        
                                        firstComponent.component[i].component.remove(at: k)
                                        secondComponent.component[j].component.remove(at: p)
                                        
                                        p = -1
                                        k = 0
                                    }
                                    
                                    p += 1
                                }
                                k += 1
                            }
                            
                            secondComponent.component[j].component.forEach { component in
                                resultTerm.component.append(SphericalComponent(trigID: component.trigID, component: component.component))
                            }
                            
                            j += 1
                        }
                        firstComponent.component[i].component.forEach { component in
                            resultTerm.component.append(SphericalComponent(trigID: component.trigID, component: component.component))
                        }
                    }
                    
                    result.component.append(resultTerm)
                    resultTerm = SphericalTerms()
                    i += 1
                }
            }
            
            return result
        }
        
        return returnVector
    }
    
    private func multiplyTriID(_ id1: String, _ id2: String) -> String {
        var trigID1: String = id1
        var returntrigID: String = ""
        
        if id1 == id2 {
            returntrigID = id2 + "2"
        } else if id1.isEmpty {
            returntrigID = id2
        } else {
            if !trigID1.isEmpty {
                var temp: String = ""
                temp = String(trigID1.removeLast())
                if trigID1 == id2 {
                    temp = String((Double(temp) ?? 1) + 1)
                    returntrigID = id2 + temp
                } else {
                    returntrigID = id2 + trigID1
                }
            } else {
                returntrigID = id2
            }
        }
        
        return returntrigID
    }
    
    private func divideVector(_ vector: SphericalCoordinateSystem, _ divideBy: SphericalCoordinateSystem) -> SphericalCoordinateSystem {
        var returnVector: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        returnVector.xComponent = divideVectors(vector.xComponent, divideBy.xComponent)
        returnVector.yComponent = divideVectors(vector.yComponent, divideBy.yComponent)
        returnVector.zComponent = divideVectors(vector.zComponent, divideBy.zComponent)
        
        func divideVectors(_ component1: SphericalCoordinateComponent, _ component2: SphericalCoordinateComponent) -> SphericalCoordinateComponent {
            var result: SphericalCoordinateComponent = SphericalCoordinateComponent()
            var resultTerm: SphericalTerms = SphericalTerms()
            var resultComponent: SphericalComponent = SphericalComponent()
            var firstComponent = component1
            var secondComponent = component2
            
            var coefficientResult: [CartesianTerms] = []
            var trigIDResult: String = ""
            
            var start: Bool = true
            if component1.component.count == 1 {
                if component1.component[0].component.isEmpty && component1.component[0].trigCoefficient.isEmpty {
                    start = false
                }
            }
            if component2.component.count == 1 {
                if component2.component[0].component.isEmpty && component2.component[0].trigCoefficient.isEmpty {
                    start = false
                }
            }
            
            var i = 0
            if start {
                while (i < firstComponent.component.count) {
                    if !firstComponent.component[i].component.isEmpty || !firstComponent.component[i].trigCoefficient.isEmpty {
                        var j = 0
                        while (j < secondComponent.component.count) {
                            coefficientResult = division(firstComponent.component[i].trigCoefficient, secondComponent.component[j].trigCoefficient)
                            resultTerm.trigCoefficient = coefficientResult
                            
                            var k = 0
                            while (k < firstComponent.component[i].component.count) {
                                var p = 0
                                while (p < secondComponent.component[j].component.count) {
                                    if firstComponent.component[i].component[k].getBases() == secondComponent.component[j].component[p].getBases() {
                                        trigIDResult = divideTriID(firstComponent.component[i].component[k].trigID, secondComponent.component[j].component[p].trigID)
                                        resultComponent = SphericalComponent(trigID: trigIDResult, component: firstComponent.component[i].component[k].component)
                                        resultTerm.component.append(resultComponent)
                                        resultComponent = SphericalComponent()
                                        
                                        firstComponent.component[i].component.remove(at: k)
                                        secondComponent.component[j].component.remove(at: p)
                                        
                                        p = -1
                                        k = 0
                                    }
                                    
                                    p += 1
                                }
                                
                                k += 1
                            }
                            
                            
                            secondComponent.component[j].component.forEach { component in
                                let temp = divideTriID("", component.trigID)
                                
                                resultTerm.component.append(SphericalComponent(trigID: temp, component: component.component))
                            }
                            
                            j += 1
                        }
                        firstComponent.component[i].component.forEach { component in
                            resultTerm.component.append(SphericalComponent(trigID: component.trigID, component: component.component))
                        }
                    }
                    
                    result.component.append(resultTerm)
                    resultTerm = SphericalTerms()
                    i += 1
                }
            }
            
            return result
        }
        
        return returnVector
    }
    
    private func divideTriID(_ id1: String, _ id2: String) -> String {
        var trigID1: String = id1
        var returntrigID: String = ""
        
        if id1 == id2 {
            returntrigID = ""
        } else {
            if !trigID1.isEmpty {
                var temp: String = ""
                temp = String(trigID1.removeLast())
                if trigID1 == id2 {
                    temp = String((Double(temp) ?? 1) - 1)
                    returntrigID = id2 + temp
                } else {
                    returntrigID = id2 + "-1" + trigID1
                }
            } else {
                returntrigID = id2 + "-1"
            }
        }
        
        return returntrigID
    }
    
    private func curl(_ vector: SphericalCoordinateSystem) -> SphericalCoordinateSystem {
        var returnVector: SphericalCoordinateSystem = SphericalCoordinateSystem()
        var answer: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        var temp1: SphericalCoordinateSystem = SphericalCoordinateSystem()
        var temp2: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        var useR: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        useR.xComponent = r.xComponent
        useR.yComponent = r.xComponent
        useR.zComponent = r.xComponent
        
        
        temp1.xComponent = differentiate(base: "θ", vector).zComponent // x1
        temp1.xComponent = divideVector(temp1, r).xComponent
        temp2.xComponent = differentiate(base: "z", vector).yComponent // x2
        
        temp1.yComponent = differentiate(base: "z", vector).xComponent // y1
        temp2.yComponent = differentiate(base: "r", vector).zComponent // y2
        
        temp1.zComponent = multiplyVector(vector, useR).yComponent // z1
        temp1.zComponent = differentiate(base: "r", temp1).zComponent
        temp2.zComponent = differentiate(base: "θ", vector).xComponent // z2
        
        answer = subtraction(temp1, temp2)
        
        returnVector.xComponent = answer.xComponent
        returnVector.yComponent = answer.yComponent
        returnVector.zComponent = divideVector(answer, useR).zComponent
        return returnVector
    }
    
    
    private func divergence(_ function: SphericalCoordinateSystem) -> SphericalCoordinateSystem {
        var returnVector: SphericalCoordinateSystem = SphericalCoordinateSystem()
        var tempX: SphericalCoordinateSystem = SphericalCoordinateSystem()
        var tempY: SphericalCoordinateSystem = SphericalCoordinateSystem()
        var tempZ: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        tempX.xComponent = multiplyVector(function, r).xComponent
        tempX.xComponent = differentiate(base: "r", tempX).xComponent
        tempX.xComponent = divideVector(tempX, r).xComponent
        
        tempY.xComponent = differentiate(base: "θ", function).yComponent
        tempY.xComponent = divideVector(tempY, r).xComponent
        
        tempZ.xComponent = differentiate(base: "z", function).zComponent
        
        returnVector.xComponent = addition(tempX, tempY).xComponent
        returnVector.xComponent = addition(returnVector, tempZ).xComponent
        
        return returnVector
    }
    
    private func gradient(_ vector: SphericalCoordinateSystem) -> SphericalCoordinateSystem {
        var returnVector: SphericalCoordinateSystem = SphericalCoordinateSystem()
        var useR: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        
        useR.xComponent = r.xComponent
        useR.yComponent = r.xComponent
        useR.zComponent = r.xComponent
        
        returnVector.xComponent = differentiate(base: "r", vector).xComponent
        
        returnVector.yComponent = differentiate(base: "θ", vector).xComponent
        returnVector.yComponent = divideVector(returnVector, useR).yComponent
        
        returnVector.zComponent = differentiate(base: "z", vector).xComponent
        
        return returnVector
        
    }
    
    private func differentiate(base: String, _ vector: SphericalCoordinateSystem) -> SphericalCoordinateSystem {
        var returnVector: SphericalCoordinateSystem = SphericalCoordinateSystem()
        
        returnVector.xComponent = perform(vector.xComponent)
        returnVector.yComponent = perform(vector.yComponent)
        returnVector.zComponent = perform(vector.zComponent)
        
        func perform(_ component: SphericalCoordinateComponent) -> SphericalCoordinateComponent {
            var answer: SphericalCoordinateComponent = SphericalCoordinateComponent()
            component.component.forEach { term in
                var differentiatedCoefficient: [CartesianTerms] = []
                var differentiatedComponent: [CartesianTerms] = []
                var differentiatedTrigID: String = ""
                var add: Bool = false
                term.trigCoefficient.forEach { coefficient in
                    let temp = differentiateComponent(base: base, component: term.trigCoefficient)
                    temp.forEach { term in
                        if term.coefficient != "0" {
                            add = true
                        }
                    }
                    differentiatedCoefficient.append(contentsOf: temp)
                }
                if add {
                    answer.component.append(SphericalTerms(trigCoefficient: differentiatedCoefficient, component: term.component))
                }
                
                var diffComp: [SphericalComponent] = []
                var temp2: [CartesianTerms] = []
                term.component.forEach { component in
                    let temp = differentiateComponent(base: base, component: component.component)
                    differentiatedComponent.append(contentsOf: temp)
                    
                    if !differentiatedComponent.isEmpty {
                        switch component.trigID {
                        case "sin":
                            differentiatedTrigID = "cos"
                            temp2 = term.trigCoefficient
                            break
                        case "cos":
                            differentiatedTrigID = "sin"
                            term.trigCoefficient.forEach { coefficient in
                                temp2.append(CartesianTerms(coefficient: String((Double(coefficient.coefficient) ?? 1) * -1),
                                                            terms: coefficient.terms))
                                
                            }
                            differentiatedCoefficient = temp
                            break
                        case "tan":
                            differentiatedTrigID = "sec2"
                            temp2 = term.trigCoefficient
                            break
                        default:
                            break
                        }
                    }
                    diffComp.append(SphericalComponent(trigID: differentiatedTrigID, component: component.component))
                }
                answer.component.append(SphericalTerms(trigCoefficient: temp2, component: diffComp))
            }
            
            return answer
        }
        
        return returnVector
    }
    
    private func differentiateComponent(base: String, component: [CartesianTerms]) -> [CartesianTerms] {
        var returnComponent: [CartesianTerms] = []
        
        component.forEach { comp in
            let tempCoefficient = differentiateTerm(base: base, coefficient: comp.coefficient, component: comp.terms).0
            let tempTerm = differentiateTerm(base: base, coefficient: comp.coefficient, component: comp.terms).1
            
            returnComponent.append(CartesianTerms(coefficient: tempCoefficient, terms: tempTerm))
        }
        return returnComponent
    }
    
    private func differentiateTerm(base: String, coefficient: String, component: [Variable])-> (String, [Variable]) {
        var returnCoefficient: String = "0"
        var returnComponent: [Variable] = []
        var mustReturn: [Variable] = []
        var a: Bool = false
        
        component.forEach { term in
            if term.base == base {
                if (Double(term.exponent) ?? 1) - 1 != 0 {
                    mustReturn.append(Variable(base: base, exponent: String((Double(term.exponent) ?? 1) - 1)))
                }
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
        }
        
        returnComponent = mustReturn
        
        return (returnCoefficient, returnComponent)
    }
   
}

struct SphericalFunctionField: View {
    @Binding var function: SphericalCoordinateComponent
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
                        ScrollView(.horizontal, showsIndicators: false) {
                            MySphericalText(axis: $function)
                        }
                        
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

// MARK: Trig Keyboard
struct CylindricalVariableKeyboard: View {
    @Binding var components: [CartesianTerms]
    @Binding var exponents: Bool
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var trignometry: Bool
    @Binding var term: CylindricalTerms
    @Binding var axis: CylindricalCoordinateComponent
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            if trignometry {
                TrigKeyBoardVariables(component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $axis, mySolveColor: $mySolveColor, myColor: $myColor)
            } else {
                CylindricalVectorKeyBoardVariables(exponents: $exponents, component: $component, variable: $variable, trignometry: $trignometry, term: $term, axis: $axis, mySolveColor: $mySolveColor, myColor: $myColor)
            }
        }
    }
}

struct TrigKeyVariable: View {
    @State var variableText: String
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var term: CylindricalTerms
    let title: String
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
                    if variable.exponent.isEmpty {
                        component.terms.append(Variable(base: variable.base, exponent: "1"))
                    } else {
                        component.terms.append(variable)
                        variable.exponent.removeAll()
                    }
                }
                
                term.trigCoefficient.append(component)
                variableText.removeLast()
                term.trigID = variableText
                
                component = CartesianTerms()
                variable = Variable()
            } label: {
                Text(String(title))
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

struct TrigKeyVariableClose: View {
    @Binding var axis: CylindricalCoordinateComponent
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var term: CylindricalTerms
    @Binding var mySolveColor: String
    
    var body: some View {
        VStack {
            Button {
                if term.trigID != "" {
                    if component.coefficient == "-" {
                        component.coefficient.append("1")
                        
                    }
                    if component.coefficient == "+" {
                        component.coefficient.append("1")
                        
                    }
                    if !variable.base.isEmpty {
                        if variable.exponent.isEmpty {
                            component.terms.append(Variable(base: variable.base, exponent: "1"))
                        } else {
                            component.terms.append(variable)
                            variable.exponent.removeAll()
                        }
                    }
                    debugPrint("component", component)
                    
                    term.component.append(component)
                    debugPrint(term)
                    axis.component.append(term)
                    
                    term = CylindricalTerms()
                    component = CartesianTerms()
                    
                    variable = Variable()
                }
            } label: {
                Text(String(")"))
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 3.2)
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(mySolveColor).opacity(0.3)))
            }
        }
    }
}

struct TrigKeyRowVariables: View {
    @State var start: Int
    @State var end: Int
    var variableTexts: [String]
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var term: CylindricalTerms
    @Binding var myColor: String
    
    var body: some View {
        HStack {
            ForEach(start..<end, id: \.self) { item in
                TrigKeyVariable(variableText: variableTexts[item], component: $component, variable: $variable, term: $term, title: variableTexts[item], myColor: $myColor)
            }
        }
    }
}

struct TrigKeyBoardVariables: View {
    let variableTexts: [String] = ["sin(", "cos(", "tan(", "sec(", "csc(", "atan(", "sin2(", "cos2(", "u"]
    @State var exponents: Bool = false
    @State var coefficient: String = ""
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var trignometry: Bool
    @Binding var term: CylindricalTerms
    @Binding var axis: CylindricalCoordinateComponent
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    
    var body: some View {
        VStack {
            TrigKeyRowVariables(start: 0, end: 3, variableTexts: variableTexts, component: $component, variable: $variable, term: $term, myColor: $myColor)
            TrigKeyRowVariables(start: 3, end: 6, variableTexts: variableTexts, component: $component, variable: $variable, term: $term, myColor: $myColor)
            TrigKeyRowVariables(start: 6, end: 9, variableTexts: variableTexts, component: $component, variable: $variable, term: $term, myColor: $myColor)
            HStack {
                TrigConstantButton(trignometry: $trignometry, mySolveColor: $mySolveColor)
                VectorKeyRowConstants(start: 0, end: 0, coefficient: $coefficient, myColor: $myColor)
                TrigKeyVariableClose(axis: $axis, component: $component, variable: $variable, term: $term, mySolveColor: $mySolveColor)
            }
        }
    }
}

struct TrigConstantButton: View {
    @Binding var trignometry: Bool
    @Binding var mySolveColor: String
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {
                    trignometry.toggle()
                }
            } label: {
                if trignometry {
                    Text(String("xy..."))
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 3.2)
                        .background(RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(mySolveColor).opacity(0.3)))
                }
                else {
                    HStack(alignment: .top, spacing: 0) {
                        Image(systemName: "sin(x)")
                            .font(.title)
                        Text(String("sin(x)"))
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 3.2)
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(mySolveColor).opacity(0.3)))
                }
            }
        }
    }
}

// MARK: Cylindrical Exponents Keyboard
struct CylindricalVectorKeyBoardExponents: View {
    @Binding var exponents: Bool
    @Binding var exponent: String
    @Binding var variable: Variable
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            CylindricalVectorKeyRowExponents(start: 1, end: 3,variable: $variable, exponent: $exponent, myColor: $myColor)
            CylindricalVectorKeyRowExponents(start: 4, end: 6,variable: $variable, exponent: $exponent, myColor: $myColor)
            CylindricalVectorKeyRowExponents(start: 7, end: 9,variable: $variable, exponent: $exponent, myColor: $myColor)
            HStack {
                ConstantExponentButton(exponents: $exponents, myColor: $mySolveColor)
                CylindricalVectorKeyRowExponents(start: 0, end: 0, variable: $variable, exponent: $exponent, myColor: $myColor)
                VectorKeyConstantsSpecial(key: ".", component: $exponent, myColor: $mySolveColor)
            }
        }
    }
}

struct CylindricalVectorKeyRowExponents: View {
    @State var start: Int
    @State var end: Int
    @Binding var variable: Variable
    @Binding var exponent: String
    @Binding var myColor: String
    
    var body: some View {
        HStack {
            ForEach(start..<end + 1, id: \.self) { item in
                CylindricalVectorKeyExponents(key: item, variable: $variable, exponent: $exponent, myColor: $myColor)
            }
        }
    }
}

struct CylindricalVectorKeyExponents: View {
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

// MARK: Cylindrical Constants Keyboard
struct CylindricalVectorKeyBoard: View {
    @State var exponents: Bool = false
    @State var exponent: String = ""
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    
    var body: some View {
        VStack {
            if exponents {
                CylindricalVectorKeyBoardExponents(exponents: $exponents, exponent: $exponent, variable: $variable, mySolveColor: $mySolveColor, myColor: $myColor)
            } else {
                CylindricalVectorKeyBoardConstants(exponents: $exponents, coefficient: $component.coefficient, mySolveColor: $mySolveColor, myColor: $myColor)
            }
        }
    }
}

struct CylindricalConstantExponentButton: View {
    @Binding var exponents: Bool
    @Binding var mySolveColor: String
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {
                    exponents.toggle()
                }
            } label: {
                if exponents {
                    Text(String("12..."))
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 3.2)
                        .background(RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.green.opacity(0.3)))
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
                        .foregroundColor(Color(mySolveColor).opacity(0.3)))
                }
            }
        }
    }
}

struct CylindricalVectorKeyBoardConstants: View {
    @Binding var exponents: Bool
    @Binding var coefficient: String
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            CylindricalVectorKeyRowConstants(start: 1, end: 3, coefficient: $coefficient, myColor: $myColor)
            CylindricalVectorKeyRowConstants(start: 4, end: 6, coefficient: $coefficient, myColor: $myColor)
            CylindricalVectorKeyRowConstants(start: 7, end: 9, coefficient: $coefficient, myColor: $myColor)
            HStack {
                ConstantExponentButton(exponents: $exponents, myColor: $mySolveColor)
                CylindricalVectorKeyRowConstants(start: 0, end: 0, coefficient: $coefficient, myColor: $myColor)
                VectorKeyConstantsSpecial(key: ".", component: $coefficient, myColor: $mySolveColor)
            }
        }
    }
}

struct CylindricalVectorKeyRowConstants: View {
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

struct CylindricalVectorKeyConstants: View {
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

// MARK: Variable Keyboard

struct CylindricalVectorKeyVariable: View {
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
                    }
                    if variable.exponent.isEmpty {
                        component.terms.append(Variable(base: variable.base, exponent: "1"))
                    } else {
                        component.terms.append(variable)
                        variable.exponent.removeAll()
                    }
                }
                
                variable.base.removeAll()
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

struct CylindricalVectorKeyRowVariables: View {
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

struct CylindricalVectorKeyBoardVariables: View {
    let variableTexts: [String] = ["x", "y", "z", "a", "b", "R", "r", "θ", "ϕ"]
    @Binding var exponents: Bool
    @State var coefficient: String = ""
    @Binding var component: CartesianTerms
    @Binding var variable: Variable
    @Binding var trignometry: Bool
    @Binding var term: CylindricalTerms
    @Binding var axis: CylindricalCoordinateComponent
    @Binding var mySolveColor: String
    @Binding var myColor: String
    
    var body: some View {
        VStack {
            CylindricalVectorKeyRowVariables(start: 0, end: 3, variableTexts: variableTexts, component: $component, variable: $variable, myColor: $myColor)
            CylindricalVectorKeyRowVariables(start: 3, end: 6, variableTexts: variableTexts, component: $component, variable: $variable, myColor: $myColor)
            CylindricalVectorKeyRowVariables(start: 6, end: 9, variableTexts: variableTexts, component: $component, variable: $variable, myColor: $myColor)
            HStack {
                TrigConstantButton(trignometry: $trignometry, mySolveColor: $mySolveColor)
                VectorKeyRowConstants(start: 0, end: 0, coefficient: $coefficient, myColor: $myColor)
                TrigKeyVariableClose(axis: $axis, component: $component, variable: $variable, term: $term, mySolveColor: $mySolveColor)
            }
        }
    }
}

struct CylindricalVariableConstantButton: View {
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
