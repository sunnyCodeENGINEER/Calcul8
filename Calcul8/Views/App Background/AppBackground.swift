//
//  AppBackground.swift
//  Swift Try
//
//  Created by Emmanuel Donkor on 14/01/2023.
//

import SwiftUI

struct AppBackground: View {
    @State var isDragging = false
    @State var position = CGSize.zero
    @Binding var currentElement: Element
    
    @AppStorage("groupBlur") var groupBlur: Double = 0
    @AppStorage("groupOpacity") var groupOpacity: Double = 0.3
    @AppStorage("functionBlur") var functionBlur: Double = 0
    @AppStorage("functionOpacity") var functionOpacity: Double = 1
    @AppStorage("functionSize") var functionSize: Double = 1
    @AppStorage("functionRotation") var functionRotation: Double = 0
    @AppStorage("functionPositionX") var functionPositionX: Double = 0
    @AppStorage("functionPositionY") var functionPositionY: Double = 0
    @AppStorage("functionColor") var functionColor: String = "tryColor"
    
    @AppStorage("percentBlur") var percentBlur: Double = 0
    @AppStorage("percentOpacity") var percentOpacity: Double = 1
    @AppStorage("percentSize") var percentSize: Double = 1
    @AppStorage("percentRotation") var percentRotation: Double = 0
    @AppStorage("percentPositionX") var percentPositionX: Double = 0
    @AppStorage("percentPositionY") var percentPositionY: Double = 0
    @AppStorage("percentColor") var percentColor: String = "tryColor"
    
    @AppStorage("divideBlur") var divideBlur: Double = 0
    @AppStorage("divideOpacity") var divideOpacity: Double = 1
    @AppStorage("divideSize") var divideSize: Double = 1
    @AppStorage("divideRotation") var divideRotation: Double = 0
    @AppStorage("dividePositionX") var dividePositionX: Double = 0
    @AppStorage("dividePositionY") var dividePositionY: Double = 0
    @AppStorage("divideColor") var divideColor: String = "tryColor"
    
    var body: some View {
        VStack {
            AppBackgroundElement(imageName: "function", currentElement: $currentElement, setTo: .function, elementBlur: $functionBlur, elementOpacity: $functionOpacity, elementScale: $functionSize, elementAngle: $functionRotation, positionFinalHeight: $functionPositionY, positionFinalWidth: $functionPositionX, color: $functionColor)
            AppBackgroundElement(imageName: "percent", currentElement: $currentElement, setTo: .percent, elementBlur: $percentBlur, elementOpacity: $percentOpacity, elementScale: $percentSize, elementAngle: $percentRotation, positionFinalHeight: $percentPositionY, positionFinalWidth: $percentPositionX, color: $percentColor)
            AppBackgroundElement(imageName: "divide.circle.fill", currentElement: $currentElement, setTo: .divide, elementBlur: $divideBlur, elementOpacity: $divideOpacity, elementScale: $divideSize, elementAngle: $divideRotation, positionFinalHeight: $dividePositionY, positionFinalWidth: $dividePositionX, color: $divideColor)
            
        }.blur(radius: CGFloat(groupBlur))
            .opacity(groupOpacity)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//            .ignoresSafeArea()
    }
}

struct AppBackground_Previews: PreviewProvider {
    static var previews: some View {
        AppBackground(currentElement: .constant(.none))
    }
}

struct AppBackgroundElement: View {
    @State var isDragging = false
    
    @State var position = CGSize.zero
    @State var positionFinal = CGSize.zero
    @State var positionPrevious = CGSize.zero
    
    var imageName: String
    @Binding var currentElement: Element
    var setTo: Element
    
    @Binding var elementBlur: Double
    @Binding var elementOpacity: Double
    @Binding var elementScale: Double
    @Binding var elementAngle: Double
    
    @State private var positionHeight: Double = 0
    @Binding var positionFinalHeight: Double
    @State private var positionPreviousHeight: Double = 0
    @State private var positionWidth: Double = 0
    @Binding var positionFinalWidth: Double
    @State private var positionPreviousWidth: Double = 0
    
    @Binding var color: String
    
    
    var body: some View {
        VStack {
//            Image(systemName: imageName)
//                .resizable()
//                .scaledToFit()
//                .offset(x:positionFinal.width, y: positionFinal.height)
//                .animation(.spring(), value: isDragging)
//                .blur(radius: elementBlur)
//                .opacity(elementOpacity)
//                .scaleEffect(elementScale)
//                .rotationEffect(Angle(degrees: elementAngle))
//                .foregroundColor(.black)
//                .gesture(
//                    DragGesture()
//                        .onChanged({ value in
//                            position = value.translation
//
//                            positionFinal = .zero
//                            positionFinal.height = position.height + positionPrevious.height
//                            positionFinal.width = position.width + positionPrevious.width
//                            isDragging = true
//                        })
//                        .onEnded({ value in
//
//                            positionPrevious = positionFinal
//                            isDragging = false
//                        }))
//                .onTapGesture {
//                    withAnimation(.easeInOut) {
//                        if currentElement != setTo {
//                            currentElement = setTo
//                        } else { currentElement = .none}
//                    }
//                }
//        }
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .offset(x:positionFinalWidth, y: positionFinalHeight)
                .animation(.spring(), value: isDragging)
                .blur(radius: elementBlur)
                .opacity(elementOpacity)
                .scaleEffect(elementScale)
                .rotationEffect(Angle(degrees: elementAngle))
                .foregroundColor(Color(color))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            positionHeight = value.translation.height
                            positionWidth = value.translation.width
                            
                            positionFinalHeight = 0
                            positionFinalWidth = 0
                            
                            positionFinalHeight = positionHeight + positionPreviousHeight
                            positionFinalWidth = positionWidth + positionPreviousWidth
                            isDragging = true
                        })
                        .onEnded({ value in
                            
                            positionPreviousHeight = positionFinalHeight
                            positionPreviousWidth = positionFinalWidth
                            isDragging = false
                        }))
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        if currentElement != setTo {
                            currentElement = setTo
                        } else { currentElement = .none}
                    }
                }
                .onAppear {
                    positionWidth = positionFinalWidth
                    positionPreviousWidth = positionFinalWidth
                    positionHeight = positionFinalHeight
                    positionPreviousHeight = positionFinalHeight
                }
        }
    }
}

enum Element {
    case function, percent, divide, none
}
