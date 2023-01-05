//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/24/22.
//

import SwiftUI

struct Tree: View {
    var goal: Goal
    @State var milestones: [Milestone] = [
        Milestone(sig: true, id: 1, name: "hi", date: "hi", imageName: "fedW", caption: "hi")
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
                    NavigationLink(destination: NewPostView(), label: {Image(systemName: "plus")})
//                    Button {
////                        var newElement = milestones.randomElement()
////                        var newThing = Milestone(sig: false, id: track, name: "hi", date: "hi", imageName: newElement!.imageName, caption: "hi")
////                        self.milestones.insert(newThing, at: 0)
////                        let first = self.milestones.first
////                        let smth = milestones[0]
////                        print(milestones[track - 2].hashValue)
////                        withAnimation {
////                            scrollView.scrollTo(milestones[0])
////                        }
////                        track += 1
//                    } label: {
//                        Image(systemName: "plus")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .padding()
                    //}
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
                                    PostView(milestone: milestone)
                                } label: {
                                    if (milestone.sig == false) {
                                        milestone.image
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                            .clipShape(Circle())
                                    }
                                    else if (milestone.sig == true) {
                                        milestone.image
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                            .clipShape(Circle())
                                            .overlay
                                            {
                                                Circle()
                                                    .stroke(.cyan, lineWidth: 5)
                                            }
                                    }
                                }
                                
                            }
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
        var temp: [Milestone] = []
        Tree(goal: Goal(name: "hi", date: "Aug 234", id: 1, milestones: temp))
    }
}
