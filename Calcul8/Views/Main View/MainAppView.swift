//
//  MainAppView.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 18/04/2022.
//

import SwiftUI

struct MainAppView: View {
    @State var outputDigit = "0"
    
    var body: some View {
        VStack{
            StandardButtonsView(output: outputDigit)
        }
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
