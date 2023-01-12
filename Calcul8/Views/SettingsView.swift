//
//  SettingsView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 03/11/2022.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    @AppStorage("buttonRadius") var buttonRadius: Double = 0.0
    
    @State var animateLogo: Bool = false
    @State var showMenu: Bool = false
    @State var menuOpacity: Bool = false
    @State var width: CGFloat = UIScreen.main.bounds.width / 8
    @State var selectTheme: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading)  {
                    Spacer(minLength: 20)
                    
                    HStack{
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: UIScreen.main.bounds.width / 4.5)
                            .padding()
                        Text("Settings".uppercased())
                            .fontWeight(.bold)
                    }
                    .font(.largeTitle)
                    .padding(.trailing)
                    
                    Text("Customize the app to suit your taste.")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(standardButton)))
                    
                    VStack{
                        HStack {
                            Text("Current Theme")
                            
                            Spacer()
                            
                            ThemeIcon(primaryColor: $standardOperator, secondaryColor: $standardButton)
                            
                        }
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                selectTheme.toggle()
                            }
                            
                        } label: {
                            Text(selectTheme ? "Done" : "Select a new theme.")
                                .padding()
                                .foregroundColor(Color("buttonText"))
                                .frame(width: UIScreen.main.bounds.width * 0.8)
                                .background(Color.gray)
                                .cornerRadius(30)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(standardButton).opacity(0.5))
                        .overlay(RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("solve"), lineWidth: 2)
                            .shadow(color: .black, radius: 30))
                    )
                    if selectTheme {
                        HStack {
                            Spacer()
                            SelectColorView()
                            Spacer()
                        }
                    }
                    
                    VStack{
                        HStack{
                            Text("Current calculator button radius.")
                            
                            Spacer()
                            
                            Text(String(format: "%.2f", buttonRadius))
                                .font(.title)
                        }
                        
                        Text("Slide to adjust calculator button radius.")
                        
                        RoundedRectangle(cornerRadius: buttonRadius)
                            .foregroundColor(Color(standardOperator))
                            .scaledToFit()
                            .frame(width: (UIScreen.main.bounds.width - (5*12)) / 4)
                        
                        Slider(value: $buttonRadius, in: 0...(UIScreen.main.bounds.width / 8))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(standardButton).opacity(0.5))
                        .overlay(RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("solve"), lineWidth: 2)
                            .shadow(color: .black, radius: 30))
                    )
                    
                }
                .padding()
            }
            .opacity(showMenu ? 0.2 : 1)
            
            LogoMenu(animateLogo: $animateLogo, showMenu: $showMenu, menuOpacity: $menuOpacity, width: $width)
                .padding(.horizontal)
        }
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
//        ThemeIcon(primaryColor: .constant("standardOperator"), secondaryColor: .constant("standardButton"))
    }
}



struct ThemeIcon: View {
    @Binding var  primaryColor: String
    @Binding var secondaryColor: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 9)
                .overlay(RoundedRectangle(cornerRadius: 0)
                .stroke(Color("solve"), lineWidth: 4))
            
            RoundedRectangle(cornerRadius: 0)
                .scaledToFit()
                .foregroundColor(Color(secondaryColor))
                .frame(width: UIScreen.main.bounds.width / 8.1)
                .overlay(RoundedRectangle(cornerRadius: 0)
                .stroke(Color("solve"), lineWidth: 4))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: UIScreen.main.bounds.width / 21, y: UIScreen.main.bounds.width / 21)
            
            RoundedRectangle(cornerRadius: 0)
                .scaledToFit()
                .foregroundColor(Color(primaryColor))
                .frame(width: UIScreen.main.bounds.width / 9)
                .overlay(RoundedRectangle(cornerRadius: 0)
                .stroke(Color("solve"), lineWidth: 4))
                .rotationEffect(Angle(degrees: 45))
                .offset(x: UIScreen.main.bounds.width / -21, y: UIScreen.main.bounds.width / -21)
        }
        .frame(width: UIScreen.main.bounds.width / 9, height: UIScreen.main.bounds.width / 9)
        .clipped()
        .background(Rectangle()
            .stroke(Color("solve"), lineWidth: 6))
    }
}
