//
//  MyTextField.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 20/11/2022.
//

import SwiftUI

struct Components: View {
    @Binding var expression: Expression
    @State var index: Int
    
    var body: some View {
        HStack {
            ForEach(0..<expression.expression[index].terms.count, id: \.self) { item in
                if expression.expression[index].terms[item].exponent != "0.0" {
                    if expression.expression[index].terms[item].base != "1" {
                        if expression.expression[index].terms[item].base != "1.0" {
                            Text(expression.expression[index].terms[item].base)
                            
                            if expression.expression[index].terms[item].exponent != "1" {
                                if expression.expression[index].terms[item].exponent != "1.0" {
                                    Text(expression.expression[index].terms[item].exponent)
                                        .font(.caption2)
                                }
                            }
                        }
                    }
                } else {
                    if expression.expression[index].terms.count < 2 {
                        Text("1")
                    }
                }
            }
        }
    }
}

struct MyTextField: View {
    @Binding var expression: Expression
    @Binding var toPerform: [AlgebraOperation]
    @Binding var operationSymbols: [String]
    
    var body: some View {
        VStack {
            if !expression.expression.isEmpty {
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
                                
                                Components(expression: $expression, index: index)
                            }
                            Text(")")
                            
                        }
                    }
                    .padding(.horizontal, 10.0)
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.green.opacity(0.6)))
                    .padding(.horizontal, 3)
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.black.opacity(0.3)))
            }
        }
    }
}

struct MyTextField_Previews: PreviewProvider {
    static var previews: some View {
        MyTextField(expression: .constant(Expression()), toPerform: .constant([]), operationSymbols: .constant([]))
    }
}
