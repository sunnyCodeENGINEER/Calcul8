//
//  ComplexOperationView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 26/04/2022.
//

import SwiftUI

struct ComplexOperationView: View {
    @Binding var solveColor: String
    @Binding var textfieldBackground: String
    
    @State var number1: ComplexNumber = ComplexNumber()
    @State var number2: ComplexNumber = ComplexNumber()
    @State var number1StringReal : String = ""
    @State var number1StringImaginary : String = ""
    @State var number2StringReal : String = ""
    @State var number2StringImaginary : String = ""
    @State var answer: ComplexNumber = ComplexNumber()
    @State var operation: ComplexNumberOperation = .addition
    @State var unit: Unit = .radians
    
    @State var convertedAnswer: PolarForm = PolarForm()
    
    @State var show: Bool = false
    
    @State var polarForm1: PolarForm = PolarForm()
    @State var polarForm2: PolarForm = PolarForm()
    
    @AppStorage("complexNumber") var complexNumber: Bool = false
    
    @State var animateLogo: Bool = false
    @State var showMenu: Bool = false
    @State var menuOpacity: Bool = false
    @State var width: CGFloat = UIScreen.main.bounds.width / 8
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button{
                        withAnimation{
                            complexNumber = false
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .tint(Color(solveColor))
                    .padding(.leading)
                    
                    Spacer()
                }
                
                Spacer(minLength: 30)
                
                Text("Enter the first complex number")
                    .padding(.top)
                
                HStack {
                    TextField("0", text: $number1StringReal)
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .frame(width: textfieldWidth(), height: textfieldWidth())
                        .background(Color(textfieldBackground).opacity(0.5))
                        .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    Text(" + ")
                    
                    TextField("0", text: $number1StringImaginary)
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .frame(width: textfieldWidth(), height: textfieldWidth())
                        .background(Color(textfieldBackground).opacity(0.5))
                        .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    Text("i")
                        .font(.title)
                        .fontWeight(.heavy)
                }
                
                HStack {
                    Text("Choose an operation to perform: ")
                    
                    //                Spacer()
                    
                    Picker(selection: $operation, label: Text("Operation")) {
                        Text("Addition").tag(ComplexNumberOperation.addition)
                        Text("Subtraction").tag(ComplexNumberOperation.subtraction)
                        Text("Multiplication").tag(ComplexNumberOperation.multiplication)
                        Text("Division").tag(ComplexNumberOperation.division)
                        Text("Convert To Polar Form").tag(ComplexNumberOperation.convertToPolarForm)
                    }
                    .tint(Color(solveColor))
                    
                }
                
                if operation != .convertToPolarForm {
                    HStack {
                        TextField("0", text: $number2StringReal)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: textfieldWidth(), height: textfieldWidth())
                            .background(Color(textfieldBackground).opacity(0.5))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text(" + ")
                        
                        TextField("0", text: $number2StringImaginary)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: textfieldWidth(), height: textfieldWidth())
                            .background(Color(textfieldBackground).opacity(0.5))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text("i")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                }
                else {
                    HStack {
                        Text("Choose a unit: ")
                        
                        Picker(selection: $unit, label: Text("Unit")) {
                            Text("𝞹 Rad").tag(Unit.piRadians)
                            Text("Radians").tag(Unit.radians)
                            Text("Degrees").tag(Unit.degrees)
                        }
                        .tint(Color(solveColor))
                        
                    }
                }
                
                HStack {
                    Spacer()
                    
                    Button{
                        withAnimation {
                        isFocused = false
                        show = true
                        }
                        
                        if operation != .convertToPolarForm {
                            withAnimation{
                                solveComplexNumberOperation()
                            }
                        } else {
                            withAnimation {
                            solveConversionToPolarForm()
                            }
                        }
                        
                    } label: {
                        Text("Solve")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("solve"))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color(solveColor)))
                    }
                    .padding(.bottom)
                }
                
                VStack {
                    Divider()
                    
                    if show {
                        VStack {
                            Text("Answer".uppercased())
                                .font(.title)
                            
                            if operation != .convertToPolarForm {
                                Text(String(format: " %.4f + %.4f i", answer.realPart, answer.imaginaryPart))
                            } else {
                                if unit == .piRadians {
                                    
                                    Text(String(format: " %.4f (cos(%.4f 𝞹 ) + sin(%.4f 𝞹 ))", convertedAnswer.magnitude, convertedAnswer.realPart, convertedAnswer.imaginaryPart))
                                } else {
                                    Text(String(format: " %.4f (cos(%.4f) + sin(%.4f ))", convertedAnswer.magnitude, convertedAnswer.realPart, convertedAnswer.imaginaryPart))
                                    
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
//                SectionPickerView()
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
        }
    }
    
    func solveComplexNumberOperation() {
        number1.realPart = Double(number1StringReal) ?? 0
        number1.imaginaryPart = Double(number1StringImaginary) ?? 0
        number2.realPart = Double(number2StringReal) ?? 0
        number2.imaginaryPart = Double(number2StringImaginary) ?? 0
        
        answer.realPart = checkComplexNumberOperation(operation: operation, number1: number1, number2: number2).realPart
        answer.imaginaryPart = checkComplexNumberOperation(operation: operation, number1: number1, number2: number2).imaginaryPart
        
    }
    
    func solveConversionToPolarForm() {
        number1.realPart = Double(number1StringReal) ?? 0
        number1.imaginaryPart = Double(number1StringImaginary) ?? 0
        
        convertedAnswer.magnitude = convertToPolarform(number: number1).magnitude
        convertedAnswer.realPart = convertToPolarform(number: number1).realPart
        convertedAnswer.imaginaryPart = convertToPolarform(number: number1).imaginaryPart
        
        convertedAnswer.realPart = checkUnit(unit: unit, number: convertedAnswer).realPart
        convertedAnswer.imaginaryPart = checkUnit(unit: unit, number: convertedAnswer).imaginaryPart
    }
    
    func textfieldWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 6
    }
}

struct ComplexOperationView_Previews: PreviewProvider {
    static var previews: some View {
        ComplexOperationView(solveColor: .constant(""), textfieldBackground: .constant(""))
    }
}
