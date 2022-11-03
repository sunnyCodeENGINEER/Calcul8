//
//  InputFieldView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 18/04/2022.
//

import SwiftUI

struct InputFieldView: View {
    var output: String = "0"
    var previousAnswer: String = "0"
    
    var body: some View {
        HStack{
            Spacer()
            
            VStack {
                HStack {
                    Text("Last Recorded Answer:")
                    
                    Text(previousAnswer)
                        .font(.headline)
                    
                    Spacer()
                }
                .frame(height: 20)
                .padding(.horizontal)
                .foregroundColor(.gray)

                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text(output)
                        .bold()
                        .font(.system(size: 62))
                    .padding()
                }
            }
        }
        .frame(width: inputWidth(), height: inputHeigth())
//        .background(.ultraThinMaterial)
        .background(RoundedRectangle(cornerRadius: 25).fill(.ultraThickMaterial))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 20)
        .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.primary, lineWidth: 2))
        .padding(.bottom, 8)
    }
    
    func inputWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (4*11))
    }
    
    func inputHeigth() -> CGFloat {
        return (UIScreen.main.bounds.width - (10*12))
    }
}

struct InputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        InputFieldView()
    }
}
