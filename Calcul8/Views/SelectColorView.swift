//
//  SelectColorView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 03/11/2022.
//

import SwiftUI

struct SelectColorView: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    
    @State var isPrim: Bool = true
    
    @State var colors: [String] = ["green1", "green2", "red", "yellow", "orange", "blue", "purple", "black", "white"]
    
    var body: some View {
        VStack{
            HStack{
                VStack {
                    Text("Primary\nApp Color.")
                        .font(.caption)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            isPrim = true
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 0)
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 8)
                            .foregroundColor(Color(standardOperator))
                            .overlay(RoundedRectangle(cornerRadius: 0)
                                .stroke(isPrim ? .black : .white, lineWidth: 2))
                            .padding()
                    }
                }
                .padding()
                
                VStack {
                    Text("Secomdary\nApp Color.")
                        .font(.caption)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            isPrim = false
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 0)
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 8)
                            .foregroundColor(Color(standardButton))
                            .overlay(RoundedRectangle(cornerRadius: 0)
                                .stroke(!isPrim ? .black : .white, lineWidth: 2))
                            .padding()
                    }
                }
                .padding()
            }
            .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(standardButton).opacity(0.6)))
            .padding(.bottom)
            
            if isPrim {
                VStack{
                    HStack{
                        ForEach (0..<3) { index in
                            SetPrimaryColor(color: $standardOperator, setColor: colors[index], colorText: colors[index])
                        }
                    }
                    HStack{
                        ForEach (3..<6) { index in
                            SetPrimaryColor(color: $standardOperator, setColor: colors[index], colorText: colors[index])
                        }
                    }
                    HStack{
                        ForEach (6..<9) { index in
                            SetPrimaryColor(color: $standardOperator, setColor: colors[index], colorText: colors[index])
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color(standardButton).opacity(0.5)))
            } else {
                VStack{
                    HStack{
                        ForEach (0..<3) { index in
                            SetPrimaryColor(color: $standardButton, setColor: colors[index], colorText: colors[index])
                        }
                    }
                    HStack{
                        ForEach (3..<6) { index in
                            SetPrimaryColor(color: $standardButton, setColor: colors[index], colorText: colors[index])
                        }
                    }
                    HStack{
                        ForEach (6..<9) { index in
                            SetPrimaryColor(color: $standardButton, setColor: colors[index], colorText: colors[index])
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color(standardButton).opacity(0.5)))
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 30)
            .foregroundColor(Color(standardButton).opacity(0.6)))
    }
}

struct SelectColorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectColorView()
    }
}

struct SetPrimaryColor: View {
    @Binding var color: String
    @State var setColor: String
    @State var colorText: String
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                color = setColor
            }
            
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 0)
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 8)
                    .foregroundColor(Color(setColor))
                    .overlay(RoundedRectangle(cornerRadius: 0)
                        .stroke((color == setColor) ? .black : .white, lineWidth: 2))
                    .padding(.horizontal)
                
                Text(colorText)
                    .foregroundColor(Color("buttonText"))
            }
        }
    }
}
