//
//  SectionDecider.swift
//  Calcul8
//
//  Created by Emmanuel Donkor on 20/04/2022.
//

import Foundation
import SwiftUI

enum SectionName: EnvironmentKey {
    static let defaultValue: Binding<SectionName> = .constant(SectionName.basicSection)
    
    case basicSection, complexSection, equationSection
}

extension EnvironmentValues {
    var section: Binding<SectionName> {
        get { self[SectionName.self]}
        set { self[SectionName.self] = newValue }
    }
}

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
//                    ComplexformDecider() // work here
                    AdvancedCalculationNavigator()
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

