//
//  PolarFormOperationView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 28/04/2022.
//

import SwiftUI

struct PolarFormOperationView: View {
    @Binding var solveColor: String
    @Binding var textfieldBackground: String
    
    @State var number1: PolarForm = PolarForm()
    @State var number2: PolarForm = PolarForm()
    @State var number1StringReal : String = ""
    @State var number1StringImaginary : String = ""
    @State var number1StringMagnitude : String = ""
    @State var number2StringReal : String = ""
    @State var number2StringImaginary : String = ""
    @State var number2StringMagnitude : String = ""
    @State var answer: PolarForm = PolarForm()
    @State var operation: PolarFormOperation = .multiplication
    @State var unit: Unit = .radians
    
    @State var convertedAnswer: ComplexNumber = ComplexNumber()
    
    @State var show: Bool = false
    
    @State var polarForm1: PolarForm = PolarForm()
    @State var polarForm2: PolarForm = PolarForm()
    
    @AppStorage("polarForm") var polarForm: Bool = false
    
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
                            polarForm = false
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
                
                if unit != .piRadians {
                    HStack {
                        TextField("0", text: $number1StringMagnitude)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: textfieldWidth(), height: textfieldWidth())
                            .background(Color(textfieldBackground).opacity(0.5))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text(" (")
                            .font(.title)
                            .fontWeight(.heavy)
                        Text("cos(")
                        
                        TextField("0", text: $number1StringReal)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: textfieldWidth(), height: textfieldWidth())
                            .background(Color(textfieldBackground).opacity(0.5))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text(") + sin(")
                        
                        TextField("0", text: $number1StringReal)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: textfieldWidth(), height: textfieldWidth())
                            .background(Color(textfieldBackground).opacity(0.5))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text(")")
                        Text(")")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                }
                else {
                    HStack {
                        TextField("0", text: $number1StringMagnitude)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: textfieldWidth(), height: textfieldWidth())
                            .background(Color(textfieldBackground).opacity(0.5))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text(" (")
                            .font(.title)
                            .fontWeight(.heavy)
                        Text("cos(")
                        
                        TextField("0", text: $number1StringReal)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: textfieldWidth(), height: textfieldWidth())
                            .background(Color(textfieldBackground).opacity(0.5))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text("𝞹) + sin(")
                        
                        TextField("0", text: $number1StringReal)
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .frame(width: textfieldWidth(), height: textfieldWidth())
                            .background(Color(textfieldBackground).opacity(0.5))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                        Text("𝞹)")
                        Text(")")
                            .font(.title)
                            .fontWeight(.heavy)
                    }            }
                
                HStack {
                    Text("Choose an operation to perform: ")
                    
                    Picker(selection: $operation, label: Text("Operation")) {
                        //                    Text("Addition").tag(ComplexNumberOperation.addition)
                        //                    Text("Subtraction").tag(ComplexNumberOperation.subtraction)
                        Text("Multiplication").tag(PolarFormOperation.multiplication)
                        Text("Division").tag(PolarFormOperation.division)
                        Text("Convert To Rectangular form").tag(PolarFormOperation.convertToComplexForm)
                    }
                    .tint(Color(solveColor))
                    
                }
                
                if operation != .convertToComplexForm {
                    if unit != .piRadians {
                        HStack {
                            TextField("0", text: $number2StringMagnitude)
                                .multilineTextAlignment(.trailing)
                                .padding()
                                .frame(width: textfieldWidth(), height: textfieldWidth())
                                .background(Color(textfieldBackground).opacity(0.5))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                            Text(" (")
                                .font(.title)
                                .fontWeight(.heavy)
                            Text("cos(")
                            
                            TextField("0", text: $number2StringReal)
                                .multilineTextAlignment(.trailing)
                                .padding()
                                .frame(width: textfieldWidth(), height: textfieldWidth())
                                .background(Color(textfieldBackground).opacity(0.5))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                            Text(") + sin(")
                            
                            TextField("0", text: $number2StringReal)
                                .multilineTextAlignment(.trailing)
                                .padding()
                                .frame(width: textfieldWidth(), height: textfieldWidth())
                                .background(Color(textfieldBackground).opacity(0.5))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                            Text(")")
                            Text(")")
                                .font(.title)
                                .fontWeight(.heavy)
                        }
                    }
                    else {
                        HStack {
                            TextField("0", text: $number2StringMagnitude)
                                .multilineTextAlignment(.trailing)
                                .padding()
                                .frame(width: textfieldWidth(), height: textfieldWidth())
                                .background(Color(textfieldBackground).opacity(0.5))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                            Text(" (")
                                .font(.title)
                                .fontWeight(.heavy)
                            Text("cos(")
                            
                            TextField("0", text: $number2StringReal)
                                .multilineTextAlignment(.trailing)
                                .padding()
                                .frame(width: textfieldWidth(), height: textfieldWidth())
                                .background(Color(textfieldBackground).opacity(0.5))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                            Text("𝞹) + sin(")
                            
                            TextField("0", text: $number2StringReal)
                                .multilineTextAlignment(.trailing)
                                .padding()
                                .frame(width: textfieldWidth(), height: textfieldWidth())
                                .background(Color(textfieldBackground).opacity(0.5))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(Color(solveColor)))
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                            Text("𝞹)")
                            Text(")")
                                .font(.title)
                                .fontWeight(.heavy)
                        }                }
                }
                
                HStack {
                    Text("Choose a unit: ")
                    
                    //                Spacer()
                    
                    Picker(selection: $unit, label: Text("Unit")) {
                        //                    Text("Addition").tag(ComplexNumberOperation.addition)
                        //                    Text("Subtraction").tag(ComplexNumberOperation.subtraction)
                        Text("𝞹 Rad").tag(Unit.piRadians)
                        Text("Radians").tag(Unit.radians)
                        Text("Degrees").tag(Unit.degrees)
                    }
                    .tint(Color(solveColor))
                    
                }
                
                HStack {
                    Spacer()
                    
                    Button{
                        withAnimation {
                        isFocused = false
                        show = true
                        }
                        
                        if operation != .convertToComplexForm {
                            withAnimation{
                                solvePolarformoperations()
                            }
                        }
                        else {
                            withAnimation{
                                solveConversionToRectangularForm()
                            }
                        }
                        
                    } label: {
                        Text("Solve")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("solve"))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color(solveColor))
                                .blur(radius: 1)
                                .shadow(color: .black, radius: 10, x: 3, y: 5))
                    }
                    .padding([.bottom, .trailing])
                }
                
                VStack {
                    Divider()
                    
                    if show {
                        VStack {
                            Text("Answer".uppercased())
                                .font(.title)
                            
                            if operation == .convertToComplexForm {
                                Text(String(format: " %.4f + %.4f i", convertedAnswer.realPart, convertedAnswer.imaginaryPart))
                            } else {
                                if unit == .piRadians {
                                    
                                    Text(String(format: " %.4f (cos(%.4f 𝞹 ) + sin(%.4f 𝞹 ))", answer.magnitude, answer.realPart, answer.imaginaryPart))
                                } else {
                                    Text(String(format: " %.4f (cos(%.4f) + sin(%.4f ))", answer.magnitude, answer.realPart, answer.imaginaryPart))
                                    
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
    
    func textfieldWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 6
    }
    
    func updateValues() {
        answer.realPart = checkUnit(unit: unit, number: answer).realPart
        answer.imaginaryPart = checkUnit(unit: unit, number: answer).imaginaryPart
    }
    
    func solvePolarformoperations() {
        if unit == .degrees {
            number1.realPart = degreesToRadians(angle: Double(number1StringReal) ?? 0)
            number1.imaginaryPart = degreesToRadians(angle: Double(number1StringReal) ?? 0)
            number1.magnitude = Double(number1StringMagnitude) ?? 0
            number2.realPart = degreesToRadians(angle: Double(number2StringReal) ?? 0)
            number2.imaginaryPart = degreesToRadians(angle: Double(number2StringReal) ?? 0)
            number2.magnitude = Double(number2StringMagnitude) ?? 0
        } else if unit == .radians {
            number1.realPart = Double(number1StringReal) ?? 0
            number1.imaginaryPart = Double(number1StringReal) ?? 0
            number1.magnitude = Double(number1StringMagnitude) ?? 0
            number2.realPart = Double(number2StringReal) ?? 0
            number2.imaginaryPart = Double(number2StringReal) ?? 0
            number2.magnitude = Double(number2StringMagnitude) ?? 0
        } else if unit == .piRadians {
            number1.realPart = (Double(number1StringReal) ?? 0) * .pi
            number1.imaginaryPart = (Double(number1StringReal) ?? 0) * .pi
            number1.magnitude = Double(number1StringMagnitude) ?? 0
            number2.realPart = (Double(number2StringReal) ?? 0) * .pi
            number2.imaginaryPart = (Double(number2StringReal) ?? 0) * .pi
            number2.magnitude = Double(number2StringMagnitude) ?? 0
        }
        
        answer.magnitude = checkPolarFormOperation(operation: operation, number1: number1, number2: number2).magnitude
        answer.realPart = checkPolarFormOperation(operation: operation, number1: number1, number2: number2).realPart
        answer.imaginaryPart = checkPolarFormOperation(operation: operation, number1: number1, number2: number2).imaginaryPart
        
        answer.realPart = checkUnit(unit: unit, number: answer).realPart
        answer.imaginaryPart = checkUnit(unit: unit, number: answer).imaginaryPart
    }
    
    func solveConversionToRectangularForm() {
        //        number1.realPart = Double(number1StringReal) ?? 0
        //        number1.imaginaryPart = Double(number1StringReal) ?? 0
        //        number1.magnitude = Double(number1StringMagnitude) ?? 0
        
        if unit == .degrees {
            number1.realPart = degreesToRadians(angle: Double(number1StringReal) ?? 0)
            number1.imaginaryPart = degreesToRadians(angle: Double(number1StringReal) ?? 0)
            number1.magnitude = Double(number1StringMagnitude) ?? 0
        } else if unit == .radians {
            number1.realPart = Double(number1StringReal) ?? 0
            number1.imaginaryPart = Double(number1StringReal) ?? 0
            number1.magnitude = Double(number1StringMagnitude) ?? 0
        } else if unit == .piRadians {
            number1.realPart = (Double(number1StringReal) ?? 0) * .pi
            number1.imaginaryPart = (Double(number1StringReal) ?? 0) * .pi
            number1.magnitude = Double(number1StringMagnitude) ?? 0
        }
        
        convertedAnswer.realPart = convertToComplexForm(number: number1).realPart
        convertedAnswer.imaginaryPart = convertToComplexForm(number: number1).imaginaryPart
    }
}

struct PolarFormOperationView_Previews: PreviewProvider {
    static var previews: some View {
        PolarFormOperationView(solveColor: .constant(""), textfieldBackground: .constant(""))
    }
}
