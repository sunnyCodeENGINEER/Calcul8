//
//  Expression.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 10/12/2022.
//

import Foundation
import SwiftUI

struct Terms: Identifiable {
    let id = UUID()
    var coefficient: String = ""
    var terms: [Term] = []
    
    subscript(number: Int) -> Term {
        get {
            return terms[number]
        }
        set {
            terms[number] = newValue
        }
    }
    
    func getBases() -> String {
        var bases: String = ""
        
        terms.forEach { term in
            bases.append(term.base)
            
        }
        
        return bases
    }
    func getExponents() -> String {
        var exponents: String = ""
        
        terms.forEach { term in
            exponents.append(term.exponent)
            
        }
        
        return exponents
    }
}
struct Expression {
    var expression: [Terms] = []
    
    subscript(index: Int) -> Terms {
        get {
            return expression[index]
        }
        set {
            expression[index] = newValue
        }
    }
    
}

struct AlgebraSpecialButton: View {
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
                    .foregroundColor(.green.opacity(0.3)))
        }
    }
}
