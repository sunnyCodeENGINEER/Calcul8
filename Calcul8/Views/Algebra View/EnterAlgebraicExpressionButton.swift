//
//  EnterAlgebraicExpressionButton.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 16/11/2022.
//

import SwiftUI

struct EnterAlgebraicExpressionButton: View {
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @Binding var receive: Bool
    
    @State var terms: [Term] = []
    @State var express = Expression()
    var body: some View {
        VStack {
            Spacer()
            Button {
                withAnimation(.easeInOut(duration: 0.3)){
                    receive = true
                }
            } label: {
                Text("Enter algebraic expression...")
                    .frame(minWidth: 300)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(standardButton).opacity(0.3))
                        .overlay(RoundedRectangle(cornerRadius: 30)
                            .stroke()))
                    .foregroundColor(.black)

            }
        }
    }
}

struct EnterAlgebraicExpressionButton_Previews: PreviewProvider {
    static var previews: some View {
        EnterAlgebraicExpressionButton(receive: .constant(true))
    }
}
