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
    @State var temp = false
    var body: some View {
        ZStack {
            ScrollViewReader { scrollView in
                Button {
                    let newElement = milestones.randomElement()
                    self.milestones.insert(newElement!, at: 0)
                    withAnimation {
                        scrollView.scrollTo(milestones[0])
                    }
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                }
                .offset(x: 160)
                ScrollView (.vertical) {
                    VStack (spacing: 30){
                        Image(milestones[0])
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
                            .offset(y:102)
                            .onAppear {
                                num = 2.0
                            }
                            .animation(.easeIn)
                        Path { path in
                            path.move(to: CGPoint(x: 195, y: -10))
                            path.addLine(to: CGPoint(x: 195, y:300))
                        }
                        .stroke(Color.black, lineWidth: 15)
                        ForEach((milestones), id: \.self) {
                            milestone in
                            if (milestone != milestones[0]) {
                                Path { path in
                                    path.move(to: CGPoint(x: 195, y: 180))
                                    path.addLine(to: CGPoint(x: 195, y:330))
                                }
                                .stroke(Color.black, lineWidth: 15)
                                Image(milestone)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                            }
                        }
                        Image("overlook-autumn")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .offset(y:30)
                            .padding(.bottom, 30)
                    }
                    .onAppear {
                        temp.toggle()
                    }
                }
            }
        }
        .background(Color.yellow)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Tree()
    }
}
