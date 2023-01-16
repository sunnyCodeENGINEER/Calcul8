//
//  MyTextField.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 20/11/2022.
//

import SwiftUI

struct Components: View {
    @Binding var terms: Terms
    
    var body: some View {
        ForEach(0..<terms.terms.count, id: \.self) { item in
            if terms.terms[item].exponent != "0.0" {
                if terms.terms[item].base != "1" {
                    if terms.terms[item].base != "1.0" {
                        Text(terms.terms[item].base)
                        
                        if terms.terms[item].exponent != "1" {
                            if terms.terms[item].exponent != "1.0" {
                                Text(terms.terms[item].exponent)
                                    .font(.caption2)
                            }
                        }
                    }
                }
            } else {
                if terms.terms.count < 2 {
                    Text("1")
                }
            }
        }
    }
}

struct MyTextField: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @Binding var expression: Expression
    @Binding var toPerform: [AlgebraOperation]
    @Binding var operationSymbols: [String]
    
    var body: some View {
        VStack {
            if !expression.expression.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 1) {
                        ForEach(0..<expression.expression.count, id: \.self) { index in
                            HStack(alignment: .top, spacing: 1) {
                                Text(operationSymbols[index])
                                Text("(")
                                if expression.expression[index].coefficient != "1" {
                                    if expression.expression[index].coefficient != "1.0" {
                                        Text(expression.expression[index].coefficient)
                                    }
                                }
                                
                                if expression.expression[index].coefficient != "0.0" {
                                    Components(terms: $expression.expression[index])
                                }
                                Text(")")
                                
                            }
                        }
                    }
                }
            } else {
                Text("0")
            }
        }
        .padding(.horizontal, 10.0)
        .padding(.vertical, 10.0)
        .background(RoundedRectangle(cornerRadius: 30)
            .foregroundColor(Color(standardButton).opacity(0.5))
            .frame(minWidth: 100)
            .overlay(RoundedRectangle(cornerRadius: 30).stroke(lineWidth: 2).foregroundColor(Color(standardOperator))))
//        .overlay(RoundedRectangle(cornerRadius: 30).stroke(lineWidth: 2).foregroundColor(Color(standardOperator)))
    }
}

struct MyTextField_Previews: PreviewProvider {
    static var previews: some View {
        MyTextField(expression: .constant(Expression()), toPerform: .constant([]), operationSymbols: .constant([]))
    }
}

