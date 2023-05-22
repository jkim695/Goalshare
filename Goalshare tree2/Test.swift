//
//  Test.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/19/23.
//
import SwiftUI
struct ContentView: View {
    @State private var isPressed = false
    @State private var showSubCircles = false
    @State private var isLongPress = false
    @State private var dragThresholdPassed = false
    @State private var changeColor = false
    @State private var changeColor1 = false
    @State private var changeColor2 = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(changeColor2 ? .purple : .red)
                    .scaleEffect(changeColor2 ? 1.0 : 0.9)
                
                    .offset(x: 40, y: -40)
                    .opacity(showSubCircles ? 1 : 0)
                    .animation(.easeInOut(duration: 0.25), value: showSubCircles)
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(changeColor1 ? .purple : .red)
                    .scaleEffect(changeColor1 ? 1.0 : 0.9)
                
                    .offset(x: 40, y: 40)
                    .opacity(showSubCircles ? 1 : 0)
                    .animation(.easeInOut(duration: 0.25), value: showSubCircles)
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .scaleEffect(isPressed ? 1.0 : 0.9)
                    .animation(.easeInOut, value: isPressed)
                NavigationLink(destination: Text("New View"), isActive: $dragThresholdPassed) {
                    EmptyView()
                }
            }
            .animation(.easeInOut, value: changeColor)
            .gesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onChanged { _ in
                        isPressed = true
                        isLongPress = true
                    }
                    .onEnded { _ in
                        if isLongPress {
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                            showSubCircles = true
                        }
                    }
                    .simultaneously(with: DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            isPressed = true
                            if abs(value.translation.height) > 50 && value.translation.width > 30 {
                                changeColor = true
                                if value.translation.height > 0 {
                                    changeColor1 = true
                                }
                                else {
                                    changeColor2 = true
                                }
                                
                            }
                            else {
                                changeColor = false
                                changeColor1 = false
                                changeColor2 = false
                            }
                        }
                        .onEnded { value in
                            isPressed = false
                            isLongPress = false
                            showSubCircles = false
                            if abs(value.translation.height) > 50 {
                                dragThresholdPassed = true
                            }
                        }
                    )
            )
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
