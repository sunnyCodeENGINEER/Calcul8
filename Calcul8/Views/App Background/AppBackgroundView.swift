//
//  AppBackgroundView.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 14/01/2023.
//

import SwiftUI

struct AppBackgroundView: View {
    @State var currentElement: Element = .none
    
    var body: some View {
        VStack {
            AppBackground(currentElement: $currentElement)
        }
    }
}

struct AppBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AppBackgroundView()
    }
}
