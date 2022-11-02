//
//  AdvancedButtonsView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 19/04/2022.
//

import SwiftUI

struct AdvancedButtonsView: View {
    @State var output: String = "0"
    @State var advancedOperation: AdvancedOperation = .none
    @State var runnungNumber = 0.00
    @State var reset: Bool = false
    
    
    let advancedButtons: [[AdvancedButtons]] = [
        [.sine, .cosine, .tangent],
        [.cosec, .sec, .cotangent],
        [.squared, .powered, .sqrRoot],
        [.otherRoot, .logarithm, .exponen]
        
    ]
    
    var body: some View {
        VStack{
            
            InputFieldView(output: output, previousAnswer: String(runnungNumber))
            
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
                                       height: self.buttonHeighttAdvanced())
                                .background(item.advancedButtonsColor)
                                .foregroundColor(Color("buttonText"))
                                .cornerRadius(self.buttonWidthAdvanced(item: item)/3)
                        }
                    }
                }
                .padding(.bottom, 3)
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
                let number = "asin("
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
                let number = "acos("
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
                let number = "atan("
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
                let number = "log10("
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
                //                let number = button.rawValue
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
                //                let number = button.rawValue
                let number = "sqrt("
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
                //                let number = button.rawValue
                let number = "cbrt("
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
            
            //        default:
            //            break
        }
    }
    
    func checker(operation: AdvancedOperation) {
        switch operation {
        case .sine, .cosine, .tangent, .cosec, .sec, .cotangent, .squared, .powered, .sqrRoot, .otherRoot, .logarithm, .exponen:
            self.output = self.output + ")"
            
        default:
            break
        }
    }
    
    //function to set button size based on screen dimensions
    func buttonWidthAdvanced(item: AdvancedButtons) -> CGFloat {
        if item == .otherRoot {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeighttAdvanced() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct AdvancedButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedButtonsView()
    }
}
