//
//  AppBackgroundSettingsView.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 14/01/2023.
//

import SwiftUI

struct AppBackgroundSettingsView: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    
    @AppStorage("groupBlur") var groupBlur: Double = 0
    @AppStorage("groupOpacity") var groupOpacity: Double = 0.3
    @AppStorage("functionBlur") var functionBlur: Double = 0
    @AppStorage("functionOpacity") var functionOpacity: Double = 1
    @AppStorage("functionSize") var functionSize: Double = 1
    @AppStorage("functionRotation") var functionRotation: Double = 0
    @AppStorage("functionColor") var functionColor: String = "tryColor"
    
    @AppStorage("percentBlur") var percentBlur: Double = 0
    @AppStorage("percentOpacity") var percentOpacity: Double = 1
    @AppStorage("percentSize") var percentSize: Double = 1
    @AppStorage("percentRotation") var percentRotation: Double = 0
    @AppStorage("percentColor") var percentColor: String = "tryColor"
    
    @AppStorage("divideBlur") var divideBlur: Double = 0
    @AppStorage("divideOpacity") var divideOpacity: Double = 1
    @AppStorage("divideSize") var divideSize: Double = 1
    @AppStorage("divideRotation") var divideRotation: Double = 0
    @AppStorage("divideColor") var divideColor: String = "tryColor"
    
    @State var currentElement: Element = .none
//    @State var groupBlur: Float = UserDefaults.standard.float(forKey: "groupBlur")
    
    @State private var height: CGFloat = 0
    @State private var width: CGFloat = 0
    
    @State private var useColor: UseColor = .other
    var body: some View {
        ScrollView {
            HStack {
                Text("Preview")
                    .padding(.horizontal)
                Spacer()
                Button {
                    reSet()
                } label: {
                    Text("Reset")
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1))
                        .padding(.trailing)
                        .tint(Color(standardOperator))
                }
            }
            VStack {
                AppBackground(currentElement: $currentElement)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("white"))
                        )
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 2))
                    .clipped()
                
            }
            .frame(width:(UIScreen.main.bounds.width / 2), height: (UIScreen.main.bounds.height / 2))
            .scaleEffect(0.5)
            
            VStack {
                ElementValueSlider(value: $groupBlur, title: "Background Blur", min: 0, max: 20)
                    .padding(.horizontal)
                    .background(Color(standardButton))
                    .cornerRadius(20)
                
                ElementValueSlider(value: $groupOpacity, title: "Background Opacity", min: 0, max: 1.0)
                    .padding(.horizontal)
                    .background(Color(standardButton))
                    .cornerRadius(20)
                
                HStack {
                    SelectElementColorScheme(title: "Use App Primary\nColor", useColor: $useColor, setTo: .primary)
                    SelectElementColorScheme(title: "Use App Secondary\nColor", useColor: $useColor, setTo: .secondary)
                    SelectElementColorScheme(title: "Use Other\nColors", useColor: $useColor, setTo: .other)
                }
                .padding(.bottom)
                .tint(Color(standardOperator))
            }
            .padding(.horizontal)
            
            if currentElement == .function {
                ElementSettingsView(blur: $functionBlur, opacity: $functionOpacity, size: $functionSize, rotation: $functionRotation, elementName: "Function")
                    .padding(.horizontal)
                
                if useColor == .other {
                    AppBackgroundColorSetting(elementColor: $functionColor, useColor: $useColor, elementName: "Function")
                }
            } else if currentElement == .percent {
                ElementSettingsView(blur: $percentBlur, opacity: $percentOpacity, size: $percentSize, rotation: $percentRotation, elementName: "Percent")
                    .padding(.horizontal)
                if  useColor == .other {
                    AppBackgroundColorSetting(elementColor: $percentColor, useColor: $useColor, elementName: "Percent")
                }
            } else if currentElement == .divide {
                ElementSettingsView(blur: $divideBlur, opacity: $divideOpacity, size: $divideSize, rotation: $divideRotation, elementName: "Division")
                    .padding(.horizontal)
                if  useColor == .other {
                    AppBackgroundColorSetting(elementColor: $divideColor, useColor: $useColor, elementName: "Division")
                }
            }
        }
    }
    
    private func reSet() {
        groupBlur = 0
        groupOpacity = 1
        functionBlur = 0
        functionOpacity = 1
        functionSize = 1
        functionRotation = 0
        functionColor = "tryColor"
        percentBlur = 0
        percentOpacity = 1
        percentSize = 1
        percentRotation = 0
        percentColor = "tryColor"
        divideBlur = 0
        divideOpacity = 1
        divideSize = 1
        divideRotation = 0
        divideColor = "tryColor"
    }
}

struct AppBackgroundSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AppBackgroundSettingsView()
    }
}

struct ElementSettingsView: View {
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    
    @Binding var blur: Double
    @Binding var opacity: Double
    @Binding var size: Double
    @Binding var rotation: Double
    var elementName: String
    
    @State private var animate: Bool = false
    
    var body: some View {
        VStack {
            Text("\(elementName) Symbol")
            ScrollView(.vertical, showsIndicators: false) {
                ElementValueSlider(value: $blur, title: "blur", min: 0, max: 20)
                ElementValueSlider(value: $opacity, title: "opacity", min: 0, max: 1)
                ElementValueSlider(value: $size, title: "size", min: 0.2, max: 2)
                ElementValueSlider(value: $rotation, title: "rotation", min: 0, max: 359)
            
            }
            .background(Color(standardButton))
            .cornerRadius(20)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut) {
                        animate = true
                    }
                }
            }
        }
        .opacity(animate ? 1 : 0)
    }
}

struct ElementValueSlider: View {
    @Binding var value: Double
    var title: String
    var min: Double
    var max: Double
    
    var body: some View {
        VStack {
            Text(String(format: title.capitalized + ": %.3f", value))
            Slider(value: $value, in: min...max) {
                Text(title.capitalized)
            } minimumValueLabel: {
                Text(String(min))
            } maximumValueLabel: {
                Text(String(max))
            }
        }.padding()
    }
}

struct SelectElementColorScheme: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    
    @AppStorage("functionColor") var functionColor: String = "tryColor"
    @AppStorage("percentColor") var percentColor: String = "tryColor"
    @AppStorage("divideColor") var divideColor: String = "tryColor"
    
    var title: String
    @Binding var useColor: UseColor
    var setTo: UseColor
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
            
            Button {
                withAnimation(.spring()) {
                    useColor = setTo
                }
                if setTo == .primary {
                    functionColor = standardOperator
                    percentColor = standardOperator
                    divideColor = standardOperator
                } else if setTo == .secondary {
                    functionColor = standardButton
                    percentColor = standardButton
                    divideColor = standardButton
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                    }

                    if useColor == setTo {
                        Image(systemName: "checkmark")
                    }
                }
                .frame(width: 40, height: 40)
            }
        }
        
    }
}

enum UseColor {
    case primary, secondary, other
}
