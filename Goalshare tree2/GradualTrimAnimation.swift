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
                let circleDiameter: CGFloat = 110
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
                .stroke(Color.white, lineWidth: 14)
                .onAppear {
                        withAnimation(.easeIn(duration: 1).delay(2.95)) {
                            animationProgress2 = 1.0
                        }
                }
                
                VStack(spacing: totalSpacing) {
                    ZStack {
                        Image("Fed_winning_wimby")
                            .resizable()
                            .opacity(backgroundOpacity)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .onAppear {
                                withAnimation(.easeIn(duration: 1)) {
                                    backgroundOpacity = 1.0
                                }
                            }
                        
                        Circle()
                            .trim(from: 0, to: animationProgress)
                            .stroke(Color.blue, lineWidth: 4)
                            .frame(width: 110)
                            .onAppear {
                                withAnimation(Animation.timingCurve(0.2, 0.6, 0.2, 1, duration: 1)) {
                                    animationProgress = 1.0
                                }
                            }
                    }
                    ZStack {
                        Image("fedW")
                            .resizable()
                            .opacity(backgroundOpacity)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .onAppear {
                                withAnimation(.easeIn(duration: 1)) {
                                    backgroundOpacity = 1.0
                                }
                            }
                        
                        Circle()
                            .trim(from: 0, to: animationProgress)
                            .stroke(Color.primary, lineWidth: 4)
                            .frame(width: 110)
                            .onAppear {
                                withAnimation(Animation.timingCurve(0.2, 0.6, 0.2, 1, duration: 1)) {
                                    animationProgress = 1.0
                                }
                            }
                    }
                    ZStack {
                        Image("fed_practice_djoko")
                            .resizable()
                            .opacity(backgroundOpacity)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .onAppear {
                                withAnimation(.easeIn(duration: 3)) {
                                    backgroundOpacity = 1.0
                                }
                            }
                        
                        Circle()
                            .trim(from: 0, to: animationProgress)
                            .stroke(Color.primary, lineWidth: 4)
                            .frame(width: 110)
                            .onAppear {
                                withAnimation(Animation.timingCurve(0.2, 0.6, 0.2, 1, duration: 3)) {
                                    animationProgress = 1.0
                                }
                            }
                    }
                    ZStack {
                        Image("Fed_practice1")
                            .resizable()
                            .opacity(backgroundOpacity)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .onAppear {
                                withAnimation(.easeIn(duration: 3)) {
                                    backgroundOpacity = 1.0
                                }
                            }
                        
                        Circle()
                            .trim(from: 0, to: animationProgress)
                            .stroke(Color.primary, lineWidth: 4)
                            .frame(width: 110)
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

