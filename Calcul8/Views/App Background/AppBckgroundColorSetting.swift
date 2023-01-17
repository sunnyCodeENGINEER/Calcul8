//
//  AppBckgroundColorSetting.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 15/01/2023.
//

import SwiftUI

struct AppBackgroundColorSetting: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    
    @State var isPrim: Bool = true
    @Binding var elementColor: String
    @Binding var useColor: UseColor
    var elementName: String
    
    @State var colors: [String] = ["green1", "green2", "red", "yellow", "orange", "blue", "purple", "black", "white"]
    
    var body: some View {
        VStack{
            HStack{
                VStack {
                    Text("\(elementName) Symbol\nColor.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            isPrim = true
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 0)
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 8)
                            .foregroundColor(Color(elementColor))
                            .overlay(RoundedRectangle(cornerRadius: 0)
                                .stroke(isPrim ? .black : .white, lineWidth: 2))
                            .padding()
                    }
                }
                .padding()
            }
            .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(standardButton).opacity(0.6)))
            .padding(.bottom)
            
            VStack{
                HStack{
                    ForEach (0..<3) { index in
                        SetPrimaryColor(color: $elementColor, setColor: colors[index], colorText: colors[index])
                    }
                }
                HStack{
                    ForEach (3..<6) { index in
                        SetPrimaryColor(color: $elementColor, setColor: colors[index], colorText: colors[index])
                    }
                }
                HStack{
                    ForEach (6..<9) { index in
                        SetPrimaryColor(color: $elementColor, setColor: colors[index], colorText: colors[index])
                    }
                }
                SetPrimaryColor(color: $elementColor, setColor: "tryColor", colorText: "Standard Black")
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(standardButton).opacity(0.5)))
        }
    }
}

struct AppBckgroundColorSetting_Previews: PreviewProvider {
    static var previews: some View {
        AppBackgroundColorSetting(elementColor: .constant("tryColor"), useColor: .constant(.other), elementName: "Function")
    }
}

//struct SetPrimaryColor: View {
//    @Binding var color: String
//    @State var setColor: String
//    @State var colorText: String
//    var body: some View {
//        Button {
//            withAnimation(.easeInOut) {
//                color = setColor
//            }
//            
//        } label: {
//            VStack {
//                RoundedRectangle(cornerRadius: 0)
//                    .scaledToFit()
//                    .frame(width: UIScreen.main.bounds.width / 8)
//                    .foregroundColor(Color(setColor))
//                    .overlay(RoundedRectangle(cornerRadius: 0)
//                        .stroke((color == setColor) ? .black : .white, lineWidth: 2))
//                    .padding(.horizontal)
//                
//                Text(colorText)
//                    .foregroundColor(Color("buttonText"))
//            }
//        }
//    }
//}

