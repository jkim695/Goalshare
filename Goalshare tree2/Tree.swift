//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/24/22.
//

import SwiftUI

struct Tree: View {
    var goal: Goal
    @State var milestones: [Milestone] = []
    @State var num = 1.0
    @State var animationAmount = 0.0
    @State var track = 2
    @State var lineNum = 2.0
    @State var made = false
    @State var temp = false
    var body: some View {
        VStack {
            NavigationStack {
                ZStack {
                    ScrollViewReader { scrollView in
                        NavigationLink(destination: NewPostView(tree: self), label: {Image(systemName: "plus")
                                .resizable()
                                .frame(width:25, height:25)
                        })
                        .offset(x: 160)
                        ScrollView (.vertical) {
                            VStack () {
                                Text(goal.name)
                                    .font(.largeTitle.bold())
                                if (milestones.isEmpty) {
                                    Text("No Milestones yet")
                                        .offset(y:300)
                                    Text("Click the + to add one!")
                                        .offset(y:300)
                                }
                                else {
                                    VStack (spacing: 30) {
                                        ForEach((milestones)) {
                                            milestone in
//                                            if (milestone != milestones[milestones.])
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
                            .toolbar(.hidden)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
            }
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {

        Tree(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, milestones: []))
    }
}
