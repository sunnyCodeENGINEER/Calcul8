//
//  SplashScreen.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 16/01/2023.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive: Bool = false
    @State private var size: Double = 0.8
    @State private var opacity: Double = 0
    @State private var infoOpacity: Double = 0
    @State private var titleOpacity: Double = 0
    
    var body: some View {
        if isActive {
            SectionDecider()
        } else {
            VStack {
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 0) {
                        Image("appLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .scaleEffect(size)
                            .opacity(opacity)
                        Text("Calcul8")
                            .font(.system(size: 30, design: .monospaced))
                            .opacity(titleOpacity)
                    }
                    Spacer()
                    
                    HStack {
                        Text("Developed by")
                        
                        Image("sCE_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                    }
                    .opacity(infoOpacity)
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1
                        self.opacity = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            self.titleOpacity = 1
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        self.infoOpacity = 1
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
