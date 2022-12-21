//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/24/22.
//

import SwiftUI

struct Tree: View {
    let milestones: [String] = [
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
            VStack {
                ScrollView {
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
                    .offset(y:50)
                    .padding(.bottom, 80)
                    .onAppear {
                        num = 2.0
                    }
                    ForEach((1...images), id: \.self) {
                        Path { path in
                            path.move(to: CGPoint(x: 195, y: -41))
                            path.addLine(to: CGPoint(x:195, y: 20))
                        }
                        .stroke(Color.black, lineWidth: 15)
                        Image(milestones[3])
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                        Text("\($0)…")
                            .hidden()
                    }
                    Path { path in
                        path.move(to: CGPoint(x: 195, y: -41))
                        path.addLine(to: CGPoint(x:195, y: 20))
                    }
                    .stroke(Color.black, lineWidth: 15)
                    Image(milestones[3])
                        .resizable()
                        .clipShape(Circle())
                        .onAppear {
                            num = 2.0
                        }
                        .overlay(
                            made ?
                            Circle()
                                .stroke(.blue)
                                .scaleEffect(num)
                                .opacity(2 - num)
                                .animation (
                                    .easeInOut(duration: num), value: num):
                                nil
                            )
                        .frame(width: 150, height: 150)
                        .animation(.interpolatingSpring(stiffness: 10, damping: 1000))
                    .frame(maxWidth: .infinity)
                }
            }
            .background(Color.yellow)
            Button {
                images += 1
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }
            .offset(x: 160, y: 380)
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Tree()
    }
}
