//
//  AdvancedCalculationListView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 08/12/2022.
//

import SwiftUI

enum AdvancedCalculation {
    case complex, vector, algebra, none
}

struct AdvancedCalculationListView: View {
    @Binding var selection: AdvancedCalculation
    
    @State var animateLogo: Bool = false
    @State var showMenu: Bool = false
    @State var menuOpacity: Bool = false
    @State var width: CGFloat = UIScreen.main.bounds.width / 8
    @State var selectTheme: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                AdvancedCalculationListRow(title: "Complex Number calculations", selection: $selection, toSet: .complex)
                AdvancedCalculationListRow(title: "Vector calculations", selection: $selection, toSet: .vector)
                AdvancedCalculationListRow(title: "Algebra calculations", selection: $selection, toSet: .algebra)
            }
            .opacity(showMenu ? 0.2 : 1)
            .animation(.easeInOut(duration: 0.8), value: showMenu)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
                .padding(.horizontal)
        }
    }
    
    
}

struct AdvancedCalculationListView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCalculationListView(selection: .constant(.none))
    }
}

struct AdvancedCalculationListRow: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @State var title: String
    @Binding var selection: AdvancedCalculation
    @State var toSet: AdvancedCalculation
    
    var body: some View {
        Button{
            withAnimation{
                selection = toSet
            }
        } label: {
            Text(title)
                .foregroundColor(Color("solve"))
                .padding()
                .padding(.horizontal)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 20)
                    .frame(width: buttonWidth())
                    .foregroundColor(Color(standardOperator)))
            
        }
    }
    
    private func buttonWidth() -> CGFloat {

        
        return (UIScreen.main.bounds.width) / 1.2    }
}
