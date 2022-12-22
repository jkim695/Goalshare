//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/24/22.
//

import SwiftUI

struct Tree: View {
    @State var milestones: [String] = [
        "overlook-autumn",
        "fedW",
        "Illustration 9",
        "Background 4",
    ]
    @State var num = 1.0
    @State var animationAmount = 0.0
    @State var lineNum = 2.0
    @State var images = 1
    @State var made = false
    var body: some View {
        ZStack {
            ScrollViewReader { scrollView in
                ScrollView (.vertical) {
                    VStack (spacing: 30){
                        ForEach((milestones), id: \.self) { milestone in
                            Path { path in
                                path.move(to: CGPoint(x: 195, y: 380))
                                path.addLine(to: CGPoint(x: 195, y:300))
                            }
                            .stroke(Color.black, lineWidth: 15)
                            if (2 == 2) {
                                Image(milestone)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .offset(y:116)
                                    .animation(
                                        .interpolatingSpring(stiffness: 10, damping: 1)
                                    )
                            }
                            else {
                                Image(milestone)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .offset(y:116)
                            }
                        }
                        Path { path in
                            path.move(to: CGPoint(x: 195, y: -75))
                            path.addLine(to: CGPoint(x:195, y: -154))
                        }
                        .stroke(Color.black, lineWidth: 15)
                        Image("overlook-autumn")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(.blue)
                                    .scaleEffect(num)
                                    .opacity(2 - num)
                                    .animation(
                                        .easeInOut(duration: num)
                                        .repeatForever(autoreverses: false),
                                        value: num))
                            .padding(.bottom, 80)
                            .offset(y:119)
                            .onAppear {
                                num = 2.0
                            }
                    }
                    .onAppear {
                        scrollView.scrollTo(milestones[0])
                    }
                }
            }
            Button {
                self.milestones.insert("fedW", at: 0)
                print(milestones[0])
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }
            .offset(x: 160, y :380)
        }
        .background(Color.yellow)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Tree()
    }
}
