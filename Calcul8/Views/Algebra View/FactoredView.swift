//
//  FactoredView.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 27/11/2022.
//

import SwiftUI

struct Term: Identifiable {
    let id = UUID()
    @State var base: String
    @State var exponent: String
    @Binding var sign: Sign
}


struct FactoredTerm: Identifiable {
    var id = UUID()
    @State var expression2: [Expression] = [Expression()]
    @State var factors: [[String]] = []
    @State var factorsExpo: [[String]] = []
    @State var factorsCoefficient: [String] = []
}

struct FactoredExpression {
    @State var expressions: [FactoredTerm] = []
}

struct Out: View {
    @Binding var factoredExpression: FactoredExpression
    @State var index: Int
    @State var index2: Int
    
    var body: some View {
        ForEach(0..<factoredExpression.expressions[index].factors[index2].count, id: \.self) { i in
            if factoredExpression.expressions[index].factors[index2][i] != "1" {
                Text(factoredExpression.expressions[index].factors[index2][i])
            }
        }
    }
}

struct OutExpo: View {
    @Binding var factoredExpression: FactoredExpression
    @State var index: Int
    @State var index2: Int
    
    var body: some View {
        ForEach(0..<factoredExpression.expressions[index].factorsExpo[index2].count, id: \.self) { i in
            if factoredExpression.expressions[index].factorsExpo[index2][i] != "1" {
                Text(factoredExpression.expressions[index].factorsExpo[index2][i])
                    .font(.caption2)
            }
        }
    }
}

struct Coefficient: View {
    @State var express: Terms
    
    var body: some View {
        if express.coefficient != "1" && !express.terms.isEmpty{
            Text(express.coefficient)
        }
    }
}

struct Remainder: View {
    @State var express: Terms
    
    var body: some View {
        ForEach(express.terms) { term in
            if term.exponent != "0.0" {
                Text(term.base)
                if term.exponent != "1" {
                    Text(term.exponent)
                        .font(.caption2)
                }
            } else if express.terms.count < 2 {
                Text("1")
            }
        }
    }
}

struct FactorsCoefficient: View {
    @State var coefficient: String
    
    var body: some View {
        if coefficient != "1" {
            Text(coefficient)
        }
    }
}

struct FactoredView: View {
    @Binding var factoredExpression: FactoredExpression
    
    var body: some View {
        HStack(alignment: .top, spacing: 1) {
            ForEach(0..<factoredExpression.expressions.count, id: \.self) { i in
                ForEach(0..<factoredExpression.expressions[i].expression2.count, id: \.self) { j in
                    Text("+")
                    FactorsCoefficient(coefficient: factoredExpression.expressions[i].factorsCoefficient[j])
                    Out(factoredExpression: $factoredExpression, index: i, index2: j)

                    OutExpo(factoredExpression: $factoredExpression, index: i, index2: j)
                    
                    Text("(")
                    ForEach(factoredExpression.expressions[i].expression2[j].expression) { express in
//                        if express.terms.count != 1 {
                            Text("+")
//                        }
                        Coefficient(express: express)
                        
//                        if express.terms.count != 1 {
                            Remainder(express: express)
//                        }
                    }
                    Text(")")
                }
            }
        }
    }
}
/*
struct FactoredView_Previews: PreviewProvider {
    static var previews: some View {
        FactoredView()
    }
}
 */
