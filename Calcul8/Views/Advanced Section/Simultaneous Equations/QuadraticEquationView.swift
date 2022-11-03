//
//  SwiftUIView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 20/04/2022.
//

import SwiftUI

struct QuadraticEquationView: View {
    @State var firstTerm: String = ""
    @State var secondTerm: String = ""
    @State var thirdTerm: String = ""
    @State var root1: Double = 0.00
    @State var root2: Double = 0.00
    @State var discriminant: Double = 0.00
    @State var rootType: String = ""
    @State var root1String: String = ""
    @State var root2String: String = ""
    @State var roots: String = ""
    
    @FocusState var isFocused: Bool
    
    @AppStorage("decimal") var decimal: Bool = true
    @AppStorage("quadraticSection") var quadraticSection: Bool = false

    @State var animateLogo: Bool = false
    @State var showMenu: Bool = false
    @State var menuOpacity: Bool = false
    @State var width: CGFloat = UIScreen.main.bounds.width / 8
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button{
                        withAnimation{
                            quadraticSection = false
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                
                Spacer(minLength: 30)
                
                Text("Input the values into boxes provided below.")
                    .padding(.top)
                
                HStack {
    //                quadraticTextField(term: firstTerm)
                    TextField("0", text: $firstTerm)
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .frame(width: textfieldWidth(), height: textfieldWidth())
                        .background(.gray.opacity(0.3))
                        .cornerRadius(15)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    Text("x²")
                    
                    Text("+")
                    
    //                quadraticTextField(term: secondTerm)
                    TextField("0", text: $secondTerm)
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .frame(width: textfieldWidth(), height: textfieldWidth())
                        .background(.gray.opacity(0.3))
                        .cornerRadius(15)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    Text("x")
                    
                    Text("+")
                    
    //                quadraticTextField(term: thirdTerm)
                    TextField("0", text: $thirdTerm)
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .frame(width: textfieldWidth(), height: textfieldWidth())
                        .background(.gray.opacity(0.3))
                        .cornerRadius(15)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    Text("= 0")
                    
                }
                HStack {
                    
                    Spacer()
                    
                    Button{
                        isFocused = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation {
                                solveQuadratic(term1: firstTerm, term2: secondTerm, term3: thirdTerm)
                            }
                        }
                       
                    } label: {
                        Text("Solve")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("solve"))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("standardOperator")))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 3)
                
                HStack {
                    Toggle(isOn: $decimal) {
                        Text("Decimal Form")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                
                VStack {
                    HStack {
                        Text(rootType)
                            .font(.title)
                    }
                    .frame(height: 100)
                    
                    Divider()
                    
                    Text(roots)
                }
                Spacer()

//                SectionPickerView()
                
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
        }
    }
    
    
    func solveQuadratic(term1: String, term2: String, term3: String) {
        //calculate the discriminant
        let a = Double(term1) ?? 0
        let b = Double(term2) ?? 0
        let c = Double(term3) ?? 0
        
        
        discriminant = ((b * b) - (4 * a * c))
        if discriminant > 0 {
            root1 = ( -b + sqrt(discriminant)) / (2 * a)
            root2 = ( -b - sqrt(discriminant)) / (2 * a)
            root1String = String(format: "Root 1: %.4f",root1)
            root2String = String(format: "Root 2: %.4f",root2)
            rootType = "Roots are real and distinct."
            roots = root1String + "\n" + root2String
        }
        else if discriminant == 0 {
            root1 = -b / (2 * a)
            root2 = root1
            root1String = String(format: "Root 1: %.4f",root1)
            root2String = String(format: "Root 2: %.4f",root2)
            rootType = "Roots are real and equal."
            roots = root1String + "\n" + root2String
        }
        else {
            if decimal {
                root1 = -b / (2 * a)
                root2 = (sqrt(-discriminant) / (2 * a))
                root1String = String(format: "%.4f",root1)
                root2String = String(format: "%.4f",root2)
                rootType = "Roots are imaginary."
                roots = "Root: " + root1String + " ± " + root2String + "i"
            }
            else {
                root1 = -b
                root2 = (-discriminant)
                root1String = "(\(root1))/\(2 * a)"
                root2String = "(√\(root2))/\(2 * a)"
                rootType = "Roots are imaginary."
                roots = "Root: " + root1String + " ± (" + root2String + ")i"
            }
        }
        
        //        else {
        //            discriminant = ((b * b) - (4 * a * c))
        //            if discriminant > 0 {
        //                root1 = ( -b + sqrt(discriminant)) / (2 * a)
        //                root2 = ( -b - sqrt(discriminant)) / (2 * a)
        //                root1String = String(format: "Root 1: %.4f",root1)
        //                root2String = String(format: "Root 2: %.4f",root2)
        //                rootType = "Roots are real and distinct."
        //                roots = root1String + "\n" + root2String
        //            }
        //            else if discriminant == 0 {
        //                root1 = -b / (2 * a)
        //                root2 = root1
        //                root1String = String(format: "Root 1: %.4f",root1)
        //                root2String = String(format: "Root 2: %.4f",root2)
        //                rootType = "Roots are real and equal."
        //                roots = root1String + "\n" + root2String
        //            }
        
    }
    
    
    func textfieldWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 6
    }
    
}

struct QuadraticEquationView_Previews: PreviewProvider {
    static var previews: some View {
        QuadraticEquationView()
    }
}

struct quadraticTextField: View {
    @State var term: String = ""
    
    var body: some View {
        TextField("0", text: $term)
            .multilineTextAlignment(.trailing)
            .padding()
            .frame(width: textfieldWidth(), height: textfieldWidth())
            .background(.gray.opacity(0.3))
            .cornerRadius(15)
            .keyboardType(.numberPad)
    }
    
    func textfieldWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 6
    }
}
