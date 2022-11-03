//
//  SectionDecider.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 20/04/2022.
//

import Foundation
import SwiftUI

struct SectionDecider: View {
    @AppStorage("basicSection") var basicSection: Bool = true
    @AppStorage("complexNumberOperation") var complexNumberOperation: Bool = false
    @AppStorage("equationsection") var equationSection: Bool = false

    var body: some View {
        if basicSection {
            withAnimation{
                MainAppView()
            }
        }
        else {
            if complexNumberOperation {
                withAnimation{
                    ComplexformDecider()
                }
            }
            else if equationSection {
                withAnimation{
                    EquationDecider()
                }
            }
            else {
                SettingsView()
            }
        }
    }
}

