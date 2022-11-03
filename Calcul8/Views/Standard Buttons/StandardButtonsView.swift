//
//  StandardButtonsView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 18/04/2022.
//

import SwiftUI

struct StandardButtonsView: View {
    @State var output: String = "0"
    @State var currentOperation: Operation = .none
    @State var advancedOperation: AdvancedOperation = .none
    @State var runnungNumber = 0.00
    @State var reset: Bool = false
    @State var advancedNumber: String = ""
    
    let standardButtons: [[StandardButtons]] = [
        [.clear,.negative, .backspace, .divide],
        [.seven, .eight, .nine, . multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .addition],
        [.zero, .decimal, .equal]
    ]
    
    let advancedButtons: [[AdvancedButtons]] = [
        [.sine, .cosine, .tangent, .squared],
        [.cosec, .sec, .cotangent, .powered],
        [.sqrRoot, .otherRoot, .logarithm, .exponen],
    ]
    
    @State var animateLogo: Bool = false
    @State var showMenu: Bool = false
    @State var menuOpacity: Bool = false
    @State var width: CGFloat = UIScreen.main.bounds.width / 8
    
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @AppStorage("specialButton") var specialButton: String = "specialButton"
    @AppStorage("buttonRadius") var buttonRadius: Double = 0.0
    
    var body: some View {
        ZStack {
            VStack{
                InputFieldView(output: output, previousAnswer: String(runnungNumber))
                
                HStack{
                    ScrollView(showsIndicators: false) {
                        ForEach(standardButtons, id: \.self) {row in
                            HStack {
                                ForEach(row, id: \.self) { item in
                                    Button{
                                        //button action
                                        self.didTap(button: item)
                                    } label: {
                                        Text(item.rawValue)
                                            .font(.system(size: 32))
                                            .frame(width: self.buttonWidth(item: item),
                                                   height: self.buttonHeightt())
                                            .background(setStandardColor(color: item.standardButtonsColor))
//                                            .background(item.standardButtonsColor)
                                            .foregroundColor(Color("buttonText"))
                                            .cornerRadius(buttonRadius)
//                                            .cornerRadius(self.buttonWidth(item: item)/3)
                                    }
                                }
                            }
                            .padding(.bottom, 3)
                        }
                        
                        ForEach(advancedButtons, id: \.self) {row in
                            HStack {
                                ForEach(row, id: \.self) { item in
                                    Button{
                                        //button action
                                        self.didTap2(button: item)
                                    } label: {
                                        Text(item.rawValue)
                                            .font(.system(size: 20))
                                            .frame(width: self.buttonWidthAdvanced(item: item),
                                                   height: self.buttonHeightt())
                                            .background(setStandardColor(color: item.advancedButtonsColor))
//                                            .background(item.advancedButtonsColor)
                                            .foregroundColor(Color("buttonText"))
//                                            .cornerRadius(self.buttonWidthAdvanced(item: item)/3)
                                            .cornerRadius(buttonRadius)
                                    }
                                }
                            }
                            .padding(.bottom, 3)
                        }
                    }
                }
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
                .padding(.horizontal)
        }
        
        
    }
    func setStandardColor(color: Color) -> Color {
        var setColor = Color(.black)
        if color == Color("standardOperator") {
            setColor = Color(standardOperator)
        } else if color == Color(.lightGray) {
            setColor = Color(specialButton)
        }
        else {
            setColor = Color(standardButton)
        }
        
        return setColor
    }
    
    func didTap(button: StandardButtons) {
        switch button {
        case .addition, .subtract, .multiply, .divide, .equal:
            //            if advancedOperation != .none {
            checker(operation: advancedOperation)
            advancedOperation = .none
            //            }
            if button == .addition {
                self.reset = false
                self.currentOperation = .addition
                self.runnungNumber += Double(self.output) ?? 0
            }
            else if button == .subtract {
                self.reset = false
                self.currentOperation = .subtract
                self.runnungNumber -= Double(self.output) ?? 0
            }
            else if button == .multiply {
                self.reset = false
                self.currentOperation = .multiply
                if self.runnungNumber == 0 {
                    self.runnungNumber = Double(self.output) ?? 0
                } else {
                    self.runnungNumber *= Double(self.output) ?? 0
                }
            }
            else if button == .divide {
                self.reset = false
                self.currentOperation = .divide
                if self.runnungNumber == 0 {
                    self.runnungNumber = Double(self.output) ?? 0
                } else {
                    self.runnungNumber /= Double(self.output) ?? 0
                    
                }
            }
            else if button == .equal {
                //            self.currentOperation = .equal
                self.reset = true
                let runningValue = self.runnungNumber
                let currentValue = Double(self.output) ?? 0
                switch self.currentOperation {
                case .addition: self.output = "\(runningValue + currentValue)"
                    advancedOperation = .none
                    
                case .subtract: self.output = "\(runningValue - currentValue)"
                    advancedOperation = .none
                    
                case .multiply: self.output = "\(runningValue * currentValue)"
                    advancedOperation = .none
                    
                case .divide: self.output = "\(runningValue / currentValue)"
                    advancedOperation = .none
                    
                case .none:
                    advancedOperation = .none
                    break
                }
            }
            
            if button != .equal {
                self.output = "0"
            }
            
        case .decimal:
            self.output = output + "."
        case .clear:
            self.output = "0"
            advancedOperation = .none
            currentOperation = .none
            runnungNumber = 0.00
            advancedNumber = ""
            
        case .backspace:
            self.output.removeLast()
            if self.output.isEmpty {
                self.output = "0"
                advancedOperation = .none
            }
        case .negative:
            if self.output != "0" {
                let toNegate = -1 * (Int(self.output) ?? 0)
                self.output = String(toNegate)
            }
            
        default:
            let number = button.rawValue
            if reset {
                self.runnungNumber = Double(self.output) ?? 0
                self.output = "0"
                self.reset = false
            }
            
            if self.output == "0" {
                output = number
            } else {
                self.output = "\(self.output)\(number)"
            }
        }
    }
    
    func didTap2(button: AdvancedButtons) {
        switch button {
        case .sine, .cosine, .tangent, .cosec, .sec, .cotangent, .squared, .powered, .sqrRoot, .otherRoot, .logarithm, .exponen:
            if button == .sine {
                self.advancedOperation = .sine
                //                let number = button.rawValue
                let number = "sin("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
                
            }
            else if button == .cosine {
                self.advancedOperation = .cosine
                //                let number = button.rawValue
                let number = "cos("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
            else if button == .tangent {
                self.advancedOperation = .tangent
                //                let number = button.rawValue
                let number = "tan("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
            else if button == .cosec {
                self.advancedOperation = .cosec
                //                let number = button.rawValue
                let number = "csc("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
            else if button == .sec {
                self.advancedOperation = .sec
                //                let number = button.rawValue
                let number = "sec("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
            else if button == .cotangent {
                self.advancedOperation = .cotangent
                //                let number = button.rawValue
                let number = "cot("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
            else if button == .squared {
                self.advancedOperation = .squared
                let number = button.rawValue
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
            else if button == .logarithm {
                self.advancedOperation = .logarithm
                //                let number = button.rawValue
                let number = "ln("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
            else if button == .exponen {
                self.advancedOperation = .exponen
                let number = "exp("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
            else if button == .sqrRoot {
                self.advancedOperation = .sqrRoot
                let number = button.rawValue
                //                    let number = "sqrt("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
            else if button == .otherRoot {
                self.advancedOperation = .otherRoot
                let number = button.rawValue
                //                    let number = "cbrt("
                if reset {
                    self.runnungNumber = Double(self.output) ?? 0
                    self.output = "0"
                    self.reset = false
                }
                
                if self.output == "0" {
                    output = number
                } else {
                    self.output = "\(self.output)*\(number)"
                }
            }
        }
    }
    
    //function to set button size based on screen dimensions
    func buttonWidth(item: StandardButtons) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeightt() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func inputWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - (4*11))
    }
    
    func inputHeigth() -> CGFloat {
        return (UIScreen.main.bounds.width - (10*12))
    }
    
    func buttonWidthAdvanced(item: AdvancedButtons) -> CGFloat {
        //        if item == .otherRoot {
        //            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        //        }
        
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeighttAdvanced() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func checker(operation: AdvancedOperation) {
        switch operation {
        case .sine, .cosine, .tangent, .cosec, .sec, .cotangent, .squared, .powered, .sqrRoot, .otherRoot, .logarithm, .exponen:
            self.output = self.output + ")"
            advancedNumber = ""
            for i in self.output {
                if i.isNumber {
                    advancedNumber += String(i)
                }
            }
            
            if operation == .sine {
                self.output = String(sin(Double(advancedNumber) ?? 0))
            }
            else if operation == .cosine {
                self.output = String(cos(Double(advancedNumber) ?? 0))
            }
            else if operation == .tangent {
                self.output = String(tan(Double(advancedNumber) ?? 0))
            }
            else if operation == .cosec {
                self.output = String(asin(Double(advancedNumber) ?? 0))
            }
            else if operation == .sec {
                self.output = String(acos(Double(advancedNumber) ?? 0))
            }
            else if operation == .cotangent {
                self.output = String(atan(Double(advancedNumber) ?? 0))
            }
            else if operation == .squared {
                self.output = String((Double(advancedNumber) ?? 0)*(Double(advancedNumber) ?? 0))
            }
            else if operation == .sqrRoot {
                self.output = String(sqrt(Double(advancedNumber) ?? 0))
            }
            else if operation == .otherRoot {
                self.output = String(cbrt(Double(advancedNumber) ?? 0))
            }
            else if operation == .logarithm {
                self.output = String(log(Double(advancedNumber) ?? 0))
            }
            else if operation == .exponen {
                self.output = String(exp(Double(advancedNumber) ?? 0))
            }
            
            
        default:
            break
        }
    }
}

struct StandardButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        StandardButtonsView()
    }
}
