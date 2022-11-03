//
//  LogoMenu.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 02/11/2022.
//

import SwiftUI

struct LogoMenu: View {
    
    @AppStorage("appLogo") var appLogo: String = "appLogo"
    @AppStorage("standardOperator") var standardOperator: String = "standardOperator"
    @AppStorage("standardButton") var standardButton: String = "standardButton"
    
    @Binding var animateLogo: Bool
    @Binding var showMenu: Bool
    @Binding var menuOpacity: Bool
    @Binding var width: CGFloat
    
    var body: some View {
        ZStack {
            if showMenu {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.ultraThickMaterial)
                    .blur(radius: 30)
                    .ignoresSafeArea()
                    .opacity(0.3)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.9)) {
                            setWidth()
                            showMenu = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                menuOpacity = false
                            }
                        }
                    }
            }
            
            HStack(alignment: showMenu ? .bottom : .top) {
                Spacer()
                
                VStack {
                    if showMenu {
                        Spacer()
                    }
                    
                    Button {
                        withAnimation(.easeOut(duration: 0.9)) {
                            setWidth()
                            showMenu.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                menuOpacity.toggle()
                            }
                        }
                    } label: {
                        Image(appLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: animateLogo ? width : width * 1.3)
                            .animation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true), value: animateLogo)
                    }
                    if showMenu {
                        HStack {
                            Spacer()
                            
                            SectionPickerView()
                                .opacity(menuOpacity ? 1 : 0)
                                .animation(.easeOut(duration: 1.2), value: menuOpacity)
                                .padding()
                            
                            Spacer()
                        }
                    }
    //                if !showMenu {
                        Spacer()
    //                }
                }
                .padding()
            }
            .onAppear {
                animateLogo = true
        }
        }
    }
    
    func setWidth() {
        if width == UIScreen.main.bounds.width / 8 {
            width = UIScreen.main.bounds.width / 2
        } else {
            width = UIScreen.main.bounds.width / 8
        }
    }
}
