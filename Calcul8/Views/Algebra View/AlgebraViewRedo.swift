//
//  AlgebraViewRedo.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 15/11/2022.
//

import SwiftUI

struct AlgebraViewRedo: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    
    @State private var expression = Expression()
    @State private var expression2: [Expression] = []
    @State private var previousExpression = Expression()
    @State private var factors: [[String]] = []
    @State private var factorsExpo: [[String]] = []
    @State private var factoredExpression: FactoredExpression = FactoredExpression()
    @State private var coefficient: String = ""
    
    @State private var receive: Bool = false
    @State private var base: String = ""
    @State private var expo: String = ""
    @State private var currentSign: Sign = .positive
    @State private var operation: AlgebraOperation = .none
    @State private var variables: Bool = false
    @State private var exponents: Bool = false
    @State private var variablesArray: [String] = ["x", "y", "z", "a", "b", "c", "u", "v", "w"]
    @State private var vars: [Term] = []
    @State private var answerVars: [Term] = []
    @State private var toPerform: [AlgebraOperation] = []
    @State private var operationSymbol: String = ""
    @State private var operationSymbols: [String] = [""]
    @State private var rep: [Term] = [Term(base: "1", exponent: "1", sign: .constant(.positive))]
    @State private var differentiateVariable: String = ""
    @State private var receiveDifferentiationVariable: Bool = false
    @State private var answer: (String, [Term]) = ("", [])
    
    @State private var answerCoefficient = ""
    @State private var showFactorized: Bool = false
    @State private var showTextField: Bool = true
    @State private var tryComp: [Term] = [Term(base: "x", exponent: "7", sign: .constant(.positive)), Term(base: "y", exponent: "12", sign: .constant(.positive))]
    @State private var trycoeff: String = "4"
    
    @State private var animateLogo: Bool = false
    @State private var showMenu: Bool = false
    @State private var menuOpacity: Bool = false
    @State private var width: CGFloat = UIScreen.main.bounds.width / 8
    
    @Binding var selection: AdvancedCalculation
    
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
                    }.padding(.leading)
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    VStack {
                        Text(operationSymbol)
                        if operation == .factorize {
                            FactoredView(factoredExpression: $factoredExpression)
                        }
                        if showTextField {
                            MyTextField(expression: $expression, toPerform: $toPerform, operationSymbols: $operationSymbols)
                        }
//                        Button {
//                            if !differentiateVariable.isEmpty {
//                                expression = differentaiteExpression(base: differentiateVariable, expressionDiff: expression)
//                            }
//                        } label: {
//                            Text("differentiate Expressions")
//                        }
//                        Button {
//                            if !differentiateVariable.isEmpty {
//                                expression = integrateExpression(base: differentiateVariable, expressionDiff: expression)
//                            }
//                        } label: {
//                            Text("integrate Expressions")
//                        }
                        
                    }
                    HStack {
                        Button {
                            showTextField = false
                            expression.expression.removeAll()
                            expression2.removeAll()
                            answerVars.removeAll()
                            answerCoefficient.removeAll()
                            base.removeAll()
                            expo.removeAll()
                            coefficient.removeAll()
                            vars.removeAll()
                            operationSymbol.removeAll()
                            operationSymbols = [""]
                            operation = .none
                            toPerform.removeAll()
                            factoredExpression.expressions.removeAll()
                            showFactorized = false
                            showTextField = true
                        } label: {
                            Text("Clear")
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2))
                        }
                        .tint(Color(standardOperator))
                    }
                    VStack {
                        Text(String(expression.expression.count))
                        Text(String(toPerform.count))
                        if operation == .differentiate {
                            HStack {
                                Text("Differentiate in terms of ")
                                Button {
                                    withAnimation(.easeOut) {
                                        receiveDifferentiationVariable = true
                                    }
                                } label: {
                                    Text(differentiateVariable.isEmpty ? "Tap to input" : differentiateVariable)
                                        .padding()
                                        .frame(width: UIScreen.main.bounds.width / 3.2)
                                        .background(RoundedRectangle(cornerRadius: 30)
                                            .foregroundColor(.green.opacity(0.3)))
                                }
                            }
                        }
                        if operation == .integrate {
                            HStack {
                                Text("Integrate in terms of ")
                                Button {
                                    withAnimation(.easeOut) {
                                        receiveDifferentiationVariable = true
                                    }
                                } label: {
                                    Text(differentiateVariable.isEmpty ? "Tap to input" : differentiateVariable)
                                        .padding()
                                        .frame(width: UIScreen.main.bounds.width / 3.2)
                                        .background(RoundedRectangle(cornerRadius: 30)
                                            .foregroundColor(.green.opacity(0.3)))
                                }
                            }
                        }
                    }
                    HStack(alignment: .top, spacing: 1){
                        Text(answerCoefficient)
                        ForEach(answerVars) { item in
                            Text(item.base)
                            Text(item.exponent)
                                .font(.caption)
                        }
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.green.opacity(0.7)))
                    }
                    VStack {
                        Text(expo)
                        HStack(alignment: .top, spacing: 1){
                            Text(coefficient)
                            ForEach(vars) { item in
                                Text(item.base)
                                if item.exponent != "1" {
                                    Text(item.exponent)
                                        .font(.caption2)
                                }
                            }
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.green.opacity(0.7)))
                        }
                    }
                    OperationButtonsRedo(operation: $operation, base: $base, expo: $expo, vars: $vars, coefficient: $coefficient, expression: $expression, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                        .tint(Color(standardOperator))
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            solve(toSolve: expression, perform: toPerform)
                            solvePlus()
                            answerVars.removeAll()
                            answerCoefficient.removeAll()
                            base.removeAll()
                            expo.removeAll()
                            coefficient.removeAll()
                            vars.removeAll()
                            operationSymbol.removeAll()
                            showFactorized = true
                        } label: {
                            Text("Solve")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("solve"))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color(standardOperator))
                                    .blur(radius: 1))
                                .shadow(color: .black, radius: 10, x: 3, y: 5)
                                .padding()
                        }
                    }
                    
                    if operation == .differentiate || operation == .integrate {
                        if receiveDifferentiationVariable {
                            DifferentiateVariablesButtonsView(variablesArray: variablesArray, differentiateVariable: $differentiateVariable)
                                .opacity(receiveDifferentiationVariable ? 1 : 0)
                        }
                    } else {
                        
                        HStack{
                            if !variables {
                                VarConstButtonsRedo(title: "Variables", variables: $variables)
                                    .opacity(!variables ? 1 : 0)
                            }
                            Spacer()
                            if variables {
                                VarConstButtonsRedo(title: "Numbers", variables: $variables)
                                    .opacity(variables ? 1 : 0)
                            }
                        }
                        
                        
                        if !variables {
                            if !exponents {
                                AlgebraConstantButtonsRedo(coefficient: $coefficient, exponents: $exponents, operation: $operation, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                            } else {
                                AlgebraExponentButtonsRedo(expo: $expo, exponents: $exponents, base: $base, vars: $vars)
                            }
                        } else {
                            AlgebraVariableButtonsRedo(variablesArray: $variablesArray, base: $base, expo: $expo, vars: $vars, operation: $operation, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                        }
                    }
                }
                .padding()
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
        }
    }
    func solvePlus() {
        if operation == .integrate {
            if !differentiateVariable.isEmpty {
                expression = integrateExpression(base: differentiateVariable, expressionDiff: expression)
            }
        } else if operation == .differentiate {
            if !differentiateVariable.isEmpty {
                expression = differentaiteExpression(base: differentiateVariable, expressionDiff: expression)
            }
        }
    }
    
    func differentaiteExpression(base: String, expressionDiff: Expression) -> Expression {
        let toDifferentaiate = expressionDiff
        var differentiatedExpression: Expression = Expression()
        
        toDifferentaiate.expression.forEach { express in
            differentiatedExpression.expression.append(Terms(
                                coefficient: differentiate(base: base, coefficient: express.coefficient, component: express.terms).0,
                                terms: differentiate(base: base, coefficient: express.coefficient, component: express.terms).1)
            )
            
        }
        
        return differentiatedExpression
    }
    
    func integrateExpression(base: String, expressionDiff: Expression) -> Expression {
        let toIntegrate = expressionDiff
        var integratedExpression: Expression = Expression()
        
        toIntegrate.expression.forEach { express in
            integratedExpression.expression.append(Terms(
                                coefficient: integrate(base: base, coefficient: express.coefficient, component: express.terms).0,
                                terms: integrate(base: base, coefficient: express.coefficient, component: express.terms).1)
            )
            
        }
        
        return integratedExpression
    }
    func differentiate(base: String, coefficient: String, component: [Term])-> (String, [Term]) {
        var returnCoefficient: String = ""
        var returnComponent: [Term] = []
        var mustReturn: [Term] = []
        var a: Bool = false
        
        component.forEach { term in
            if term.base == base {
                mustReturn.append(Term(base: base, exponent: String((Double(term.exponent) ?? 1) - 1), sign: .constant(.positive)))
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
            mustReturn.append(Term(base: base, exponent: "0", sign: .constant(.positive)))
        }
        
        returnComponent = mustReturn
        
        print(returnCoefficient)
        print(returnComponent)
        return (returnCoefficient, returnComponent)
    }
    
    func integrate(base: String, coefficient: String, component: [Term])-> (String, [Term]) {
        var returnCoefficient: String = ""
        var returnComponent: [Term] = []
        var mustReturn: [Term] = []
        var a: Bool = false
        var b: Bool = false

        component.forEach { term in
            if term.base == base {
                mustReturn.append(Term(base: base, exponent: String((Double(term.exponent) ?? 1) + 1), sign: .constant(.positive)))
                returnCoefficient = String((Double(coefficient) ?? 1) / ((Double(term.exponent) ?? 1) + 1))
                a = true
            } else {
                mustReturn.append(term)
            }
        }
        
        if !a {
            mustReturn.append(Term(base: base, exponent: "1", sign: .constant(.positive)))
        }
        
        if returnCoefficient == "0.0" {
            b = true
        }
        
        if b {
            mustReturn.removeAll()
            mustReturn.append(Term(base: base, exponent: "0", sign: .constant(.positive)))
        }
        
        returnComponent = mustReturn
        
        print(returnCoefficient)
        print(returnComponent)
        return (returnCoefficient, returnComponent)
    }

    
    func sortExpression(expression: Expression, toPerform: [AlgebraOperation], symbols: [String]) -> (Expression, [AlgebraOperation], [String]) {
        var toSetExpression: Expression = Expression()
        var sortedToPerform = toPerform
        var express = expression
        var toSetSymbols = symbols
        
        sortedToPerform.insert(.addition, at: 0)
        toSetSymbols[0] = "+"
        
        
        // algorithm used -> BUBBLE SORT
        // loop to access each array element
        for i in (0..<express.expression.count) {
                // loop to compare array elements
            for j in (0..<((express.expression.count) - (i + 1))) {
                    // compare two adjacent elements
                    // change > to < to sort in descending order
                if express.expression[j].getBases() > express.expression[j + 1].getBases() {
                    // swapping elements if elements are not in intended order
                    let temp = express.expression[j]
                    express.expression[j] = express.expression[j + 1]
                    express.expression[j + 1] = temp
                    
                    
                    let temp2 = sortedToPerform[j]
                    sortedToPerform[j] = sortedToPerform[j + 1]
                    sortedToPerform[j + 1] = temp2
                    
                    let temp3 = toSetSymbols[j]
                    toSetSymbols[j] = toSetSymbols[j + 1]
                    toSetSymbols[j + 1] = temp3
                    }
                
                // swap elements according to their exponents
                if express.expression[j].getBases() == express.expression[j + 1].getBases() {
                    // swapping elements if elements are not in intended order
                    if express.expression[j].getExponents() > express.expression[j + 1].getExponents() {
                        // swapping elements if elements are not in intended order
                        let temp = express.expression[j]
                        express.expression[j] = express.expression[j + 1]
                        express.expression[j + 1] = temp
                        
                        
                        let temp2 = sortedToPerform[j]
                        sortedToPerform[j] = sortedToPerform[j + 1]
                        sortedToPerform[j + 1] = temp2
                        
                        let temp3 = toSetSymbols[j]
                        toSetSymbols[j] = toSetSymbols[j + 1]
                        toSetSymbols[j + 1] = temp3
                    }
                }
            }
            
            
            
            toSetExpression = express
        }
        
        if sortedToPerform[0] == .subtraction {
            toSetExpression.expression[0].coefficient.insert("-", at: coefficient.startIndex)
        }
        sortedToPerform.removeFirst()
        toSetSymbols[0] = ""
        
        return (toSetExpression, sortedToPerform, toSetSymbols)
    }
    
    func sortExpressionExponents(expression: Expression, toPerform: [AlgebraOperation], symbols: [String]) -> (Expression, [AlgebraOperation], [String]) {
        var toSetExpression: Expression = Expression()
        var sortedToPerform = toPerform
        var express = expression
        var toSetSymbols = symbols
        
        sortedToPerform.insert(.addition, at: 0)
        toSetSymbols[0] = "+"
        
        
        // algorithm used -> BUBBLE SORT
        // loop to access each array element
        for i in (0..<express.expression.count) {
                // loop to compare array elements
            for j in (0..<((express.expression.count) - (i + 1))) {
                    // compare two adjacent elements
                    // change > to < to sort in descending order
                if express.expression[j].getExponents() > express.expression[j + 1].getExponents() {
                    // swapping elements if elements are not in intended order
                    let temp = express.expression[j]
                    express.expression[j] = express.expression[j + 1]
                    express.expression[j + 1] = temp
                    
                    
                    let temp2 = sortedToPerform[j]
                    sortedToPerform[j] = sortedToPerform[j + 1]
                    sortedToPerform[j + 1] = temp2
                    
                    let temp3 = toSetSymbols[j]
                    toSetSymbols[j] = toSetSymbols[j + 1]
                    toSetSymbols[j + 1] = temp3
                    }
                }
            
            
            toSetExpression = express
        }
        
        if sortedToPerform[0] == .subtraction {
            toSetExpression.expression[0].coefficient.insert("-", at: coefficient.startIndex)
        }
        sortedToPerform.removeFirst()
        toSetSymbols[0] = ""
        
        return (toSetExpression, sortedToPerform, toSetSymbols)
    }
    
    func sortTerms(expression: Expression) -> Expression {
        var toSetExpression: Expression = Expression()
//        let toSetExpression: Expression = expression
        var toSetTerm: [Term] = []
        //        var inserted: Bool = false
        
        // algorithm used -> BUBBLE SORT
        expression.expression.forEach { express in
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
            
            toSetExpression.expression.append(Terms(coefficient: express.coefficient, terms: toSetTerm))
            toSetTerm.removeAll()
        }
        return toSetExpression
    }
    
    func solve(toSolve: Expression, perform: [AlgebraOperation]) {
        var i = 0
        // empty coefficient
        if coefficient.isEmpty {
            // vars not empty
            if !vars.isEmpty {
                expression.expression.append(Terms(coefficient: "1", terms: vars))
            }
        } else {
            // not empty coefficient
            // vars empty
            if vars.isEmpty {
                expression.expression.append(Terms(coefficient: coefficient, terms: rep))
            } else {
                // vars not empty
                expression.expression.append(Terms(coefficient: coefficient, terms: vars))
            }
        }
        vars.removeAll()
        base.removeAll()
        expo.removeAll()
        coefficient.removeAll()
        
        // sort expressions
        expression = sortTerms(expression: expression)
        
        // if an operation in operations is == multiplication
        while (i < toPerform.count) {
            if toPerform[i] == .division {
                division(coeff1: expression.expression[i].coefficient, term1: expression.expression[i].terms, coeff2: expression.expression[i + 1].coefficient, term2: expression.expression[i + 1].terms)
                
                expression.expression[i].coefficient = answerCoefficient
                expression.expression[i].terms = answerVars
                
                expression.expression.remove(at: i + 1)
                toPerform.remove(at: i)
                i = -1
            }
            i += 1
        }
        i = 0
        while (i < toPerform.count) {
            if toPerform[i] == .multiplication {
                multiplication(coeff1: expression.expression[i].coefficient, term1: expression.expression[i].terms, coeff2: expression.expression[i + 1].coefficient, term2: expression.expression[i + 1].terms)
                
                expression.expression[i].coefficient = answerCoefficient
                expression.expression[i].terms = answerVars
                
                expression.expression.remove(at: i + 1)
                toPerform.remove(at: i)
                i = -1
            }
            
            i += 1
        }
        i = 0
        
        // group terms according to their bases
        expression = sortExpression(expression: expression, toPerform: toPerform, symbols: operationSymbols).0
        toPerform = sortExpression(expression: expression, toPerform: toPerform, symbols: operationSymbols).1
        operationSymbols = sortExpression(expression: expression, toPerform: toPerform, symbols: operationSymbols).2
        
        
        
        while (i < toPerform.count) {
            if toPerform[i] == .addition {
                let successful = addition(coeff1: expression.expression[i].coefficient, term1: expression.expression[i].terms, coeff2: expression.expression[i + 1].coefficient, term2: expression.expression[i + 1].terms)
                
                if successful {
                    expression.expression[i].coefficient = answerCoefficient
                    expression.expression[i].terms = answerVars
                    
                    expression.expression.remove(at: i + 1)
                    toPerform.remove(at: i)
                    i = -1
                }
            }
            i += 1
        }
        i = 0
        
        while (i < toPerform.count) {
            if toPerform[i] == .subtraction {
                let successful = subtraction(coeff1: expression.expression[i].coefficient, term1: expression.expression[i].terms, coeff2: expression.expression[i + 1].coefficient, term2: expression.expression[i + 1].terms)
                
                if successful {
                    expression.expression[i].coefficient = answerCoefficient
                    expression.expression[i].terms = answerVars
                    
                    expression.expression.remove(at: i + 1)
                    toPerform.remove(at: i)
                    i = -1
                }
            }
            i += 1
        }
        i = 0
        
        expression = sortTerms(expression: expression)
        operation = .none
        
        factoredExpression = factorize(expression: expression)
    }
    
    func multiplication(coeff1: String, term1: [Term], coeff2: String, term2: [Term]) {
        var firstTerm = term1
        var secondTerm = term2
        var i = 0
        var j = 0
        var possibleAnswer: [Term] = []
        
        if firstTerm.count > secondTerm.count {
            while (i < firstTerm.count) {
                while (j < secondTerm.count) {
                    if firstTerm[i].base == secondTerm[j].base {
                        possibleAnswer.append(Term(base: firstTerm[i].base, exponent: String((Double(firstTerm[i].exponent) ?? 1) + (Double(secondTerm[j].exponent) ?? 1)), sign: .constant(.positive)))
                        
                        firstTerm.remove(at: i)
                        secondTerm.remove(at: j)
                        i = 0
                        j = 0
                    } else {
                        j += 1
                    }
                }
                j = 0
                i += 1
            }
        } else {
            while (i < secondTerm.count) {
                while (j < firstTerm.count) {
                    if secondTerm[i].base == firstTerm[j].base {
                        possibleAnswer.append(Term(base: secondTerm[i].base, exponent: String((Double(firstTerm[j].exponent) ?? 1) + (Double(secondTerm[i].exponent) ?? 1)), sign: .constant(.positive)))
                        
                        firstTerm.remove(at: j)
                        secondTerm.remove(at: i)
                        i = 0
                        j = 0
                    } else {
                        j += 1
                    }
                }
                j = 0
                i += 1
            }
        }
        answerVars.removeAll()
        answerCoefficient = String(Double(coeff1)! * Double(coeff2)!)
        answerVars.append(contentsOf: possibleAnswer)
        if !firstTerm.isEmpty {
            answerVars.append(contentsOf: firstTerm)
        }
        if !secondTerm.isEmpty {
            answerVars.append(contentsOf: secondTerm)
        }
    }
    
    func division(coeff1: String, term1: [Term], coeff2: String, term2: [Term]) {
        var firstTerm = term1
        var secondTerm = term2
        var i = 0
        var j = 0
        var possibleAnswer: [Term] = []
        if firstTerm.count > secondTerm.count {
            while (i < firstTerm.count) {
                while (j < secondTerm.count) {
                    if firstTerm[i].base == secondTerm[j].base {
                        possibleAnswer.append(Term(base: firstTerm[i].base, exponent: String((Double(firstTerm[i].exponent) ?? 1) - (Double(secondTerm[j].exponent) ?? 1)), sign: .constant(.positive)))
                        
                        firstTerm.remove(at: i)
                        secondTerm.remove(at: j)
                        i = 0
                        j = 0
                    } else {
                        j += 1
                    }
                }
                j = 0
                i += 1
            }
        } else {
            while (i < secondTerm.count) {
                while (j < firstTerm.count) {
                    if secondTerm[i].base == firstTerm[j].base {
                        possibleAnswer.append(Term(base: secondTerm[i].base, exponent: String((Double(firstTerm[j].exponent) ?? 1) - (Double(secondTerm[i].exponent) ?? 1)), sign: .constant(.positive)))
                        
                        firstTerm.remove(at: j)
                        secondTerm.remove(at: i)
                        i = 0
                        j = 0
                    } else {
                        j += 1
                    }
                }
                j = 0
                i += 1
            }
        }
        answerVars.removeAll()
        answerCoefficient = String(Double(coeff1)! / Double(coeff2)!)
        answerVars.append(contentsOf: possibleAnswer)
        if !firstTerm.isEmpty {
            answerVars.append(contentsOf: firstTerm)
        }
        if !secondTerm.isEmpty {
            secondTerm.forEach { term in
                answerVars.append(Term(base: term.base, exponent: String("-" + term.exponent), sign: term.$sign))
            }
        }
    }
    
    func addition(coeff1: String, term1: [Term], coeff2: String, term2: [Term]) -> Bool {
        var firstTerm = term1
        var secondTerm = term2
        var i = 0
        var j = 0
        var continueIter = true
        var possibleAnswer: [Term] = []
        var successful = false
        
        if firstTerm.count == secondTerm.count {
            while continueIter {
                while (i < firstTerm.count) {
//                    while (j < secondTerm.count) {
                        if firstTerm[i].base == secondTerm[j].base && firstTerm[i].exponent == secondTerm[j].exponent{
                            possibleAnswer.append(Term(base: firstTerm[i].base, exponent: String((Double(firstTerm[i].exponent) ?? 1)), sign: .constant(.positive)))
                            
                            firstTerm.remove(at: i)
                            secondTerm.remove(at: i)
                            i = -1
                            j = 0
                            answerCoefficient = String((Double(coeff1) ?? -1) + (Double(coeff2) ?? -1))
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
        } else {
            //            answerVars.append(contentsOf: firstTerm)
            //            answerVars.append(contentsOf: secondTerm)
        }
        return successful
    }
    
    func subtraction(coeff1: String, term1: [Term],coeff2: String, term2: [Term]) -> Bool {
        var firstTerm = term1
        var secondTerm = term2
        var i = 0
        var j = 0
        var continueIter = true
        var possibleAnswer: [Term] = []
        var successful = false
        
        if firstTerm.count == secondTerm.count {
            while continueIter {
                while (i < firstTerm.count) {
                        if firstTerm[i].base == secondTerm[j].base && firstTerm[i].exponent == secondTerm[j].exponent{
                            possibleAnswer.append(Term(base: firstTerm[i].base, exponent: String((Double(firstTerm[i].exponent) ?? 1)), sign: .constant(.positive)))
                            
                            firstTerm.remove(at: i)
                            secondTerm.remove(at: j)
                            i = -1
                            j = 0
                            answerCoefficient = String((Double(coeff1) ?? -1) + (Double(coeff2) ?? -1))
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
        
        return successful
    }
    
    func gcd(a: String, b: String) -> String {
        var ret = ""
        if Int(b) == 0 {
            ret = a
        } else {
            ret = gcd(a: b, b: String((Int(a) ?? 1) % (Int(b) ?? 1)))
        }
        
        return ret
    }
    
    func getDivisor(factorOut: String, expression: Expression) -> String {
        var setDivisor: String = ""
        var foundOne = false
        
        for i in 0..<expression.expression.count {
            if expression.expression[i].coefficient == "1" {
                foundOne = true
            }
            
            if i == 0 {
                setDivisor = gcd(a: factorOut, b: expression.expression[i].coefficient)
            }
            print(i)
            print(gcd(a: factorOut, b: expression.expression[i].coefficient))
            print(setDivisor > gcd(a: factorOut, b: expression.expression[i].coefficient))
            if setDivisor < gcd(a: factorOut, b: expression.expression[i].coefficient) {
                setDivisor.removeAll()
                setDivisor = gcd(a: factorOut, b: expression.expression[i].coefficient)
            }
        }
        
        if foundOne {
            setDivisor = "1"
        }
        print("divisor")
        print(setDivisor)
        return setDivisor
    }
    
    func factorize(expression: Expression) -> FactoredExpression {
        var factoredExpression: FactoredExpression = FactoredExpression()
        var finexpressions: FactoredTerm = FactoredTerm()
        var expression2: [Expression] = []
        var factors: [[String]] = []
        var factorsExpo: [[String]] = []
        var factorsCoefficient: [String] = []
        
        var toBeFactored: Expression = Expression()
        var factored: Expression = Expression()
        var factoredTerms: [Term] = []
        var factoredCoefficient: String = ""
        var factorizeOutBases: [String] = []
        var factorizeOutExpo: [String] = []
        var factorizeOutCoefficient = ""
        var i = 0 // factorize remaining terms
        var j = 0 // factor next common term
        
        var k = 0
        var isPresent: Bool = true
        
        while (i < expression.expression.count) {
            let base = expression.expression[i].getBases()
            let expos = expression.expression[i].getExponents()
            
            factorizeOutBases = base.map { String($0) }
            factorizeOutExpo = expos.map { String($0) }
            factorizeOutCoefficient = expression.expression[i].coefficient
            
            // getting terms with similar bases
            
            expression.expression.forEach { express in
                print(j)
                print("I am in here")
                print(express.terms[j].base, "--", factorizeOutBases[j])
                print(factorizeOutExpo[j])
                if express.terms[j].base == factorizeOutBases[j] {
                    print("I am in here too")
                    toBeFactored.expression.append(express)
                    print(express.terms[j].base, "--", factorizeOutBases[j])
                    print(toBeFactored.expression.count)
                    i += 1
                }
            }
            
            
            
            toBeFactored.expression.forEach { express in
                j = 0
                express.terms.forEach { term in
                    j = 0
                    factorizeOutBases.forEach { term in
                        if express.terms[j].base == factorizeOutBases[j] {
                            print("I am in here too")
                            print(express.terms[j].base, "--", factorizeOutBases[j])
                            
                            j += 1
                        }
                    }
                }
            }
                
                print(toBeFactored.expression.count)
                var divisor = getDivisor(factorOut: factorizeOutCoefficient, expression: toBeFactored)
                print("\n")
                print(toBeFactored)
                var tryyy = ""
                while (isPresent) {
                    factorizeOutBases.forEach { base in
                        print("\n verify - \(toBeFactored.expression.count)")
                        k = 0
                        toBeFactored.expression.forEach { express in
                            if !(express.terms[k].base == base) {
                                isPresent = false
                            } else {
                                k = 0
                            }
                        }
                        var z = 0
                        if isPresent {
                            while (z < toBeFactored.expression.count) {
                                k = 0
                                while (k < j) {
                                    toBeFactored.expression[z].terms[k].exponent = String((Int(toBeFactored.expression[z].terms[k].exponent) ?? 1) - (Int(factorizeOutExpo[k]) ?? 0))
                                    
                                    tryyy = String((Double(toBeFactored.expression[z].terms[k].exponent) ?? 1) - (Double(factorizeOutExpo[k]) ?? 0))
                                    print(tryyy)
                                    factoredTerms.append(Term(base: toBeFactored.expression[z].terms[k].base, exponent: tryyy, sign: .constant(.positive)))
                                    k += 1
                                }
                                if (toBeFactored.expression[z].terms.count > k) {
                                    var ap = k
                                    while (ap < toBeFactored[z].terms.count) {
                                        factoredTerms.append(Term(base: toBeFactored.expression[z].terms[ap].base, exponent: toBeFactored.expression[z].terms[ap].exponent, sign: .constant(.positive)))
                                        
                                        ap += 1
                                    }
                                }
                                factoredCoefficient = toBeFactored.expression[z].coefficient
                                print("divisor - \(divisor)")
                                print("factoredOutCoefficient - \(factoredCoefficient)")
                                
                                factored.expression.append(Terms(coefficient: String((Int(factoredCoefficient) ?? 1) / ((Int(divisor) ?? 1))), terms: factoredTerms))
                                print("\n\n")
                                print(tryyy)
                                print(factoredTerms)
                                print(factored)
                                print(factored.expression.count)
                                print("\n\n")
                                print(factorizeOutExpo)
                                tryyy.removeAll()
                                factoredTerms.removeAll()
                                factoredCoefficient.removeAll()
                                z += 1
                            }
                            //                        facotredCoefficient = toBeFactored.expression[z].coefficient
                        }
                    }
                    isPresent = false
                }
                j = 0
                k = 0
                
                
                finexpressions = FactoredTerm(expression2: [factored], factors: [factorizeOutBases], factorsExpo: [factorizeOutExpo])
                print(finexpressions)
                
                print("\n\n Here we are...\n")
                print(j)
                print(factorizeOutBases)
                expression2.append(factored)
                factors.append(factorizeOutBases)
                factorsExpo.append(factorizeOutExpo)
                //            factorsCoefficient.append(factorizeOutCoefficient)
                factorsCoefficient.append(divisor)
                
                factoredExpression.expressions.append(FactoredTerm(expression2: [factored], factors: [factorizeOutBases], factorsExpo: [factorizeOutExpo]))
                
                factored.expression.removeAll()
                toBeFactored.expression.removeAll()
                factorizeOutBases.removeAll()
                factorizeOutExpo.removeAll()
                factorizeOutCoefficient.removeAll()
                divisor.removeAll()
                isPresent = true
                
                print("\nFine Expression")
                print(finexpressions)
                print("\n")
                print(factored)
                print(factored.expression.count)
                print(i)
                print(tryyy)
            }
//        }
        print("\n")
        print(expression2)
        factoredExpression = FactoredExpression(expressions: [FactoredTerm(expression2: expression2, factors: factors, factorsExpo: factorsExpo, factorsCoefficient: factorsCoefficient)])
        print(factors)
        print(factorsExpo)
        print("\nFactored expression components")
        print(factoredExpression)
        
        return factoredExpression
    }
}

//struct AlgebraViewRedo_Previews: PreviewProvider {
//    static var previews: some View {
//        AlgebraViewRedo()
//    }
//}

struct AlgebraButtonRedo: View {
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @State var number: Int
    @Binding var coefficient: String
    @Binding var operation: AlgebraOperation
    @Binding var toPerform: [AlgebraOperation]
    @Binding var operationSymbol: String
    @Binding var operationSymbols: [String]
    var body: some View {
        Button {
            coefficient.append(String(number))
            
            if operation != .none {
                toPerform.append(operation)
                operation = .none
            }
            if !operationSymbol.isEmpty {
                operationSymbols.append(operationSymbol)
                operationSymbol.removeAll()
            }
        } label: {
            Text(String(number))
                .font(.title)
                .foregroundColor(.black
                )
                .padding()
                .frame(width: UIScreen.main.bounds.width / 3.2)
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color(standardButton).opacity(0.3)))
            
        }
    }
}

struct AlgebraButtonDecimalRedo: View {
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @State var decimal: String
    @Binding var coefficient: String
    var body: some View {
        Button {
            coefficient.append(String(decimal))
        } label: {
            Text(String(decimal))
                .font(.title)
                .foregroundColor(.black
                )
                .padding()
                .frame(width: UIScreen.main.bounds.width / 3.2)
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color(standardButton).opacity(0.3)))
            
        }
    }
}

struct AlgebraExponentButtonRedo: View {
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @State var number: Int
    @Binding var expo: String
    @Binding var base: String
    @Binding var vars: [Term]
    var body: some View {
        Button {
            expo.append(String(number))
            if !base.isEmpty {
                vars.removeLast()
                if expo.isEmpty {
                    vars.append(Term(base: base, exponent: "1", sign: .constant(.positive)))
                } else {
                    // exponent is not empty
                    vars.append(Term(base: base, exponent: expo, sign: .constant(.positive)))
                    //                    expo.removeAll()
                }
            }
        } label: {
            HStack(alignment: .top, spacing: 1) {
                Image(systemName: "character.textbox")
                    .font(.system(size: 35))
                    .opacity(0.6)
                Text(String(number))
                    .font(.system(size: 18))
            }
            .foregroundColor(.black)
            .padding()
            .frame(width: UIScreen.main.bounds.width / 3.2)
            .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(standardButton).opacity(0.3)))
        }
    }
}

struct AlgebraExponentDecimalButtonRedo: View {
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @State var number: String
    @Binding var expo: String
    @Binding var base: String
    @Binding var vars: [Term]
    var body: some View {
        Button {
            expo.append(String(number))
            if !base.isEmpty {
                vars.removeLast()
                if expo.isEmpty {
                    vars.append(Term(base: base, exponent: "1", sign: .constant(.positive)))
                } else {
                    // exponent is not empty
                    vars.append(Term(base: base, exponent: expo, sign: .constant(.positive)))
                    //                    expo.removeAll()
                }
            }
        } label: {
            HStack(alignment: .top, spacing: 1) {
                Image(systemName: "character.textbox")
                    .font(.system(size: 35))
                    .opacity(0.6)
                Text(String(number))
                    .font(.system(size: 18))
            }
            .foregroundColor(.black)
            .padding()
            .frame(width: UIScreen.main.bounds.width / 3.2)
            .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(standardButton).opacity(0.3)))
        }
    }
}

struct AlgebraExponentButtonRedo_Previews: PreviewProvider {
    static var previews: some View {
        AlgebraExponentButtonRedo(number: 1, expo: .constant("1"), base: .constant(""), vars: .constant([]))
    }
}

struct AlgebraVariableButtonRedo: View {
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @Binding var variable: String
    @Binding var base: String
    @Binding var expo: String
    @Binding var vars: [Term]
    @Binding var operation: AlgebraOperation
    @Binding var toPerform: [AlgebraOperation]
    @Binding var operationSymbol: String
    @Binding var operationSymbols: [String]
    
    @State var terms: [Term] = []
    @State var express = Expression()
    var body: some View {
        Button {
            // not empty base
            if !base.isEmpty {
                base.removeAll()
            }
            base = variable
            // exponent is empty
            expo.removeAll()
            
            //            if operation != .none {
            //                toPerform.append(operation)
            //            }
            
            if !base.isEmpty {
                if expo.isEmpty {
                    vars.append(Term(base: variable, exponent: "1", sign: .constant(.positive)))
                } else {
                    // exponent is not empty
                    vars.append(Term(base: variable, exponent: expo, sign: .constant(.positive)))
                    expo.removeAll()
                }
            }
            if operation != .none {
                toPerform.append(operation)
                operation = .none
            }
            if !operationSymbol.isEmpty {
                operationSymbols.append(operationSymbol)
                operationSymbol.removeAll()
            }
        } label: {
            Text(String(variable))
                .font(.title)
                .foregroundColor(.black
                )
                .padding()
                .frame(width: UIScreen.main.bounds.width / 3.2)
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color(standardButton).opacity(0.3)))
        }
    }
}

struct AlgebraSpecialButtonRedo: View {
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @State var character: String
    var body: some View {
        Button {
            
        } label: {
            Text(String(character))
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.black)
                .padding()
                .frame(width: UIScreen.main.bounds.width / 3.2)
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color(standardButton).opacity(0.3)))
        }
    }
}

struct VarConstButtonsRedo: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    var title: String
    @Binding var variables: Bool
    
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
                    .foregroundColor(Color(standardOperator).opacity(0.3)))
        }
    }
}

struct AlgebraConstantButtonsRedo: View {
    @Binding var coefficient: String
    @Binding var exponents: Bool
    @Binding var operation: AlgebraOperation
    @Binding var toPerform: [AlgebraOperation]
    @Binding var operationSymbol: String
    @Binding var operationSymbols: [String]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1..<4) { number in
                    AlgebraButtonRedo(number: number, coefficient: $coefficient, operation: $operation, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                }
            }
            HStack {
                ForEach(4..<7) { number in
                    AlgebraButtonRedo(number: number, coefficient: $coefficient, operation: $operation, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                }
            }
            HStack {
                ForEach(7..<10) { number in
                    AlgebraButtonRedo(number: number, coefficient: $coefficient, operation: $operation, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                }
            }
            HStack {
                AlgebraNumberExponentButtonRedo(exponents: $exponents)
                AlgebraButtonRedo(number: 0, coefficient: $coefficient, operation: $operation, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                AlgebraButtonDecimalRedo(decimal: ".", coefficient: $coefficient)
            }
        }
    }
}

struct AlgebraExponentButtonsRedo: View {
    @Binding var expo: String
    @Binding var exponents: Bool
    @Binding var base: String
    @Binding var vars: [Term]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1..<4) { number in
                    AlgebraExponentButtonRedo(number: number, expo: $expo, base: $base, vars: $vars)
                }
            }
            HStack {
                ForEach(4..<7) { number in
                    AlgebraExponentButtonRedo(number: number, expo: $expo, base: $base, vars: $vars)
                }
            }
            HStack {
                ForEach(7..<10) { number in
                    AlgebraExponentButtonRedo(number: number, expo: $expo, base: $base, vars: $vars)
                }
            }
            HStack {
                AlgebraExponentNumberButtonRedo(exponents: $exponents)
                AlgebraExponentButtonRedo(number: 0, expo: $expo, base: $base, vars: $vars)
                AlgebraExponentDecimalButtonRedo(number: ".", expo: $expo, base: $base, vars: $vars)
            }
        }
    }
}

struct AlgebraVariableButtonsRedo: View {
    @Binding var variablesArray: [String]
    @Binding var base: String
    @Binding var expo: String
    @Binding var vars: [Term]
    @Binding var operation: AlgebraOperation
    @Binding var toPerform: [AlgebraOperation]
    @Binding var operationSymbol: String
    @Binding var operationSymbols: [String]
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<3) { index in
                    AlgebraVariableButtonRedo(variable: $variablesArray[index], base: $base, expo: $expo, vars: $vars, operation: $operation, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                }
            }
            HStack {
                ForEach(3..<6) { index in
                    AlgebraVariableButtonRedo(variable: $variablesArray[index], base: $base, expo: $expo, vars: $vars, operation: $operation, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                }
            }
            HStack {
                ForEach(6..<9) { index in
                    AlgebraVariableButtonRedo(variable: $variablesArray[index], base: $base, expo: $expo, vars: $vars, operation: $operation, toPerform: $toPerform, operationSymbol: $operationSymbol, operationSymbols: $operationSymbols)
                }
            }
            HStack {
                AlgebraSpecialButton(character: ".")
                AlgebraSpecialButton(character: "0")
                AlgebraSpecialButton(character: ".")
            }
        }
    }
}

struct OperationButtonsRedo: View {
    @Binding var operation: AlgebraOperation
    let operations: [AlgebraOperation] = [.addition, .subtraction, .multiplication, .division]
    let titles: [String] = ["+", "-", "*", "/"]
    let symbols: [String] = ["+", "+", "*", "/"]
    
    @Binding var base: String
    @Binding var expo: String
    @Binding var vars: [Term]
    @Binding var coefficient: String
    @Binding var expression: Expression
    @State var rep: [Term] = [Term(base: "1", exponent: "1", sign: .constant(.positive))]
    @State var previousExpression: Expression = Expression()
    @Binding var toPerform: [AlgebraOperation]
    @Binding var operationSymbol: String
    @Binding var operationSymbols: [String]
    var body: some View {
        HStack{
            ForEach(0..<4) { index in
                Button {
                    // empty coefficient
                    if coefficient.isEmpty {
                        // vars not empty
                        if !vars.isEmpty {
                            expression.expression.append(Terms(coefficient: "1", terms: vars))
                        }
                    } else {
                        // not empty coefficient
                        // vars empty
                        if vars.isEmpty {
                            expression.expression.append(Terms(coefficient: coefficient, terms: rep))
                        } else {
                            // vars not empty
                            expression.expression.append(Terms(coefficient: coefficient, terms: vars))
                        }
                    }
                    vars.removeAll()
                    base.removeAll()
                    expo.removeAll()
                    coefficient.removeAll()
                    
                    operation = operations[index]
                    operationSymbol = titles[index]
                    //                    toPerform.append(operation)
                    if operationSymbol == "+" {
                        coefficient.removeAll()
                    }
                    if operationSymbol == "-" {
                        coefficient.append("-")
                        operationSymbol = "+"
                    }
                    if expression.expression.isEmpty {
                        operation = .none
                        operationSymbol = ""
                    }
                    if expression.expression.isEmpty && (operations[index] == .multiplication || operations[index] == .division) {
                        operation = .none
                        operationSymbol = ""
                    }
                    
                } label: {
                    Text(titles[index])
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(5.0)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 40)
                            .foregroundColor(.black.opacity(operation == operations[index] ? 1 : 0.5)))
                }
            }
            Spacer()
            HStack {
                Picker("Other", selection: $operation) {
                    Text("other").tag(AlgebraOperation.none)
                    Text("factorize").tag(AlgebraOperation.factorize)
                    Text("differentiate").tag(AlgebraOperation.differentiate)
                    Text("integrate").tag(AlgebraOperation.integrate)
//                    Text("limit").tag(AlgebraOperation.limit)
                }
            }
            .frame(minWidth: UIScreen.main.bounds.width / 5)
        }
    }
}

struct AlgebraNumberExponentButtonRedo: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @Binding var exponents: Bool
    
    var body: some View {
        Button {
            exponents = true
        } label: {
            HStack(alignment: .top, spacing: 1) {
                Image(systemName: "character.textbox")
                    .font(.system(size: 35))
                    .opacity(0.6)
                Text(String("?"))
                    .font(.system(size: 18))
            }
            .foregroundColor(.black)
            .padding()
            .frame(width: UIScreen.main.bounds.width / 3.2)
            .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(standardOperator).opacity(0.3)))
        }
    }
}

struct AlgebraExponentNumberButtonRedo: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @Binding var exponents: Bool
    
    var body: some View {
        Button {
            exponents = false
        } label: {
            Text("123...")
            
                .foregroundColor(.black)
                .padding()
                .frame(width: UIScreen.main.bounds.width / 3.2)
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color(standardOperator).opacity(0.3)))
        }
    }
}

struct DifferentiateVariableButton: View {
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @State var variable: String
    @Binding var differentiateVariable: String
    
    var body: some View {
        Button {
            differentiateVariable = variable
        } label: {
            Text(String(variable))
                .font(.title)
                .foregroundColor(.black
                )
                .padding()
                .frame(width: UIScreen.main.bounds.width / 3.2)
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.green.opacity(0.3)))
        }
    }
}

struct DifferentiateVariablesButtonsView: View {
    @State var variablesArray: [String]
    @Binding var differentiateVariable: String
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<3) { index in
                    DifferentiateVariableButton(variable: variablesArray[index], differentiateVariable: $differentiateVariable)
                }
            }
            HStack {
                ForEach(3..<6) { index in
                    DifferentiateVariableButton(variable: variablesArray[index], differentiateVariable: $differentiateVariable)
                }
            }
            HStack {
                ForEach(6..<9) { index in
                    DifferentiateVariableButton(variable: variablesArray[index], differentiateVariable: $differentiateVariable)
                }
            }
            HStack {
                AlgebraSpecialButton(character: ".")
                AlgebraSpecialButton(character: "0")
                AlgebraSpecialButton(character: ".")
            }
        }
    }
}
