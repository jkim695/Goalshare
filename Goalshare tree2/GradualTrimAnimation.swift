//
//  GradualTrimAnimation.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/2/23.
//
import SwiftUI

class MyState: ObservableObject {
    @Published var animate: Bool = false
    var isAnimationActive = false // Store animate status when user switches between tabs
}
struct GradualTrimAnimation: View {
    @State var backgroundOpacity: Double
    @State var animationProgress: CGFloat
    @State var animationProgress2: CGFloat
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let circleDiameter: CGFloat = 75
                let totalSpacing: CGFloat = 35
                let circleCount: CGFloat = 4
                let totalHeight: CGFloat = circleDiameter * circleCount + totalSpacing * (circleCount - 1)
                
                Path { path in
                    let startY = geometry.size.height / 2 - totalHeight / 2 + circleDiameter / 2
                    let endY = geometry.size.height / 2 + totalHeight / 2 - circleDiameter / 2
                    path.move(to: CGPoint(x: geometry.size.width / 2, y: endY))
                    path.addLine(to: CGPoint(x: geometry.size.width / 2, y: startY))
                }
                .trim(from: 0, to: animationProgress2)
                .stroke(Color.white, lineWidth: 7)
                .onAppear {
                        withAnimation(.easeIn(duration: 1).delay(1.95)) {
                            animationProgress2 = 1.0
                        }
                }
                
                VStack(spacing: totalSpacing) {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .opacity(backgroundOpacity)
                            .frame(width: 75)
                            .onAppear {
                                withAnimation(.easeIn(duration: 2)) {
                                    backgroundOpacity = 1.0
                                }
                            }
                        
                        Circle()
                            .trim(from: 0, to: animationProgress)
                            .stroke(Color.primary, lineWidth: 2)
                            .frame(width: 75)
                            .onAppear {
                                withAnimation(Animation.timingCurve(0.2, 0.6, 0.2, 1, duration: 3)) {
                                    animationProgress = 1.0
                                }
                            }
                    }
                    ZStack {
                        Circle()
                            .fill(Color.yellow)
                            .opacity(backgroundOpacity)
                            .frame(width: 75)
                            .onAppear {
                                withAnimation(.easeIn(duration: 2)) {
                                    backgroundOpacity = 1.0
                                }
                            }
                        
                        Circle()
                            .trim(from: 0, to: animationProgress)
                            .stroke(Color.primary, lineWidth: 2)
                            .frame(width: 75)
                            .onAppear {
                                withAnimation(Animation.timingCurve(0.2, 0.6, 0.2, 1, duration: 3)) {
                                    animationProgress = 1.0
                                }
                            }
                    }
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .opacity(backgroundOpacity)
                            .frame(width: 75)
                            .onAppear {
                                withAnimation(.easeIn(duration: 2)) {
                                    backgroundOpacity = 1.0
                                }
                            }
                        
                        Circle()
                            .trim(from: 0, to: animationProgress)
                            .stroke(Color.primary, lineWidth: 2)
                            .frame(width: 75)
                            .onAppear {
                                withAnimation(Animation.timingCurve(0.2, 0.6, 0.2, 1, duration: 3)) {
                                    animationProgress = 1.0
                                }
                            }
                    }
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .opacity(backgroundOpacity)
                            .frame(width: 75)
                            .onAppear {
                                withAnimation(.easeIn(duration: 2)) {
                                    backgroundOpacity = 1.0
                                }
                            }
                        
                        Circle()
                            .trim(from: 0, to: animationProgress)
                            .stroke(Color.primary, lineWidth: 2)
                            .frame(width: 75)
                            .onAppear {
                                withAnimation(Animation.timingCurve(0.2, 0.6, 0.2, 1, duration: 3)) {
                                    animationProgress = 1.0
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
struct GradualTrimAnimation_Previews: PreviewProvider {
    static var previews: some View {
        GradualTrimAnimation(backgroundOpacity: 0, animationProgress: 0, animationProgress2: 0)
            .background(.pink)
    }
}

