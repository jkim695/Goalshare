//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/24/22.
//

import SwiftUI

struct Tree: View {
    @State var milestones: [Milestone] = [
        Milestone(id: 1, name: "hi", date: "hi", imageName: "fedW")
    ]
    @State var num = 1.0
    @State var animationAmount = 0.0
    @State var track = 2
    @State var lineNum = 2.0
    @State var made = false
    @State var temp = false
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollViewReader { scrollView in
                    Button {
                        var newElement = milestones.randomElement()
                        var newThing = Milestone(id: track, name: "hi", date: "hi", imageName: newElement!.imageName)
                        self.milestones.insert(newThing, at: 0)
                        let first = self.milestones.first
                        let smth = milestones[0]
                        print(milestones[track - 2].hashValue)
                        withAnimation {
                            scrollView.scrollTo(milestones[0])
                        }
                        track += 1
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                    .offset(x: 160)
//                    NavigationLink {
//                        NewPostView()
//                    } label: {
//                        Text("hi")
//                            .font(.largeTitle)
//                    }
                    ScrollView (.vertical) {
                        VStack (spacing: 30){
//                            Image(milestones[0])
//                                .resizable()
//                                .frame(width: 150, height: 150)
//                                .clipShape(Circle())
//                                .overlay(
//                                    Circle()
//                                        .stroke(.blue)
//                                        .scaleEffect(num)
//                                        .opacity(2 - num)
//                                        .animation(
//                                            .easeInOut(duration: num)
//                                            .repeatForever(autoreverses: false),
//                                            value: num))
//                                .padding(.bottom, 80)
//                                .offset(y:102)
//                                .onAppear {
//                                    num = 2.0
//                                }
//                                .animation(.easeIn)
//                            Path { path in
//                                path.move(to: CGPoint(x: 195, y: -10))
//                                path.addLine(to: CGPoint(x: 195, y:300))
//                            }
            //                .stroke(Color.black, lineWidth: 15)
                            ForEach((milestones)) {
                                milestone in
                                    Path { path in
                                        path.move(to: CGPoint(x: 195, y: 180))
                                        path.addLine(to: CGPoint(x: 195, y:330))
                                    }
                                    .stroke(Color.black, lineWidth: 15)
                                
                                NavigationLink {
                                    MatchedGeometryTest()
                                } label: {
                                    milestone.image
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
                    }
                }
            }
            .background(Color.yellow)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Tree()
    }
}
