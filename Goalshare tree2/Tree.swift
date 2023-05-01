//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/24/22.
//

import SwiftUI
import FirebaseAnalyticsSwift

struct Tree: View {
    @EnvironmentObject var goal: Goal
    @Environment(\.presentationMode) var presentationMode
    @State private var offset: CGFloat = 0
    @State private var atTopOfScrollView = true
    @State private var addingMilestone = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all) // Set the background color to yellow
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "house.circle")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .padding()
                            }
                            Spacer()
                        }
                        HStack (spacing: 20) {
                            Spacer()
                            ShareLink(item: /*@START_MENU_TOKEN@*/URL(string: "https://developer.apple.com/xcode/swiftui")!/*@END_MENU_TOKEN@*/)
                            {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .frame(width: 23, height: 32)
                            }
                            Button(action: {
                                addingMilestone = true
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width:25, height:25)
                            }
                            .navigationDestination(for: Int.self) { int in
                                AddMilestone().environmentObject(goal)
                            }
                        }
                    }
                    .padding(.trailing)
                    HStack (alignment: .center) {
                        Spacer()
                        Text(goal.name)
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    
                    ScrollView(.vertical) {
                        if (goal.milestones.isEmpty) {
                            EmptyMilestoneMessage()
                        }
                        else {
                            ZStack {
                                Path { path in
                                    path.move(to: CGPoint(x: geometry.size.width / 2, y: 5))
                                    path.addLine(to: CGPoint(x: Int(geometry.size.width) / 2, y: 150 * goal.milestones.count))
                                }
                                .stroke(Color.black, lineWidth: 15)
                                .frame(height: CGFloat(150 * goal.milestones.count))
                                .frame(maxWidth: .infinity)
                                MilestoneChain()
                                    .environmentObject(goal)
                                    .offset(y: 5)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .fullScreenCover(isPresented: $addingMilestone) {
        AddMilestone()
            .environmentObject(goal)
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
        .navigationBarBackButtonHidden(true)
        .analyticsScreen(name: "\(Tree.self)")
    }
}

struct Trees_Previews: PreviewProvider {
    static var previews: some View {
        Tree()
            .environmentObject(Goal(name: "Ace test", date: Date(), color: Color.red))
    }
}





