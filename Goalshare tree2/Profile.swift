//
//  Profile.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI

struct Profile: View {
    var body: some View {
            NavigationStack {
                VStack {
                    Text("My Goals.")
                        .font(.largeTitle)
                    Spacer()
                    NavigationLink(destination: AddGoal(), label: {
                        Text("Add Goal")
                            .foregroundColor(Color.black)
                            .font(.system(size: 22.0))
                            .frame(width: 100)
                            .background(.yellow)
                            .cornerRadius(15)
                        }
                    )
                    Spacer()
                    ScrollView {
                        Spacer()
                        HStack {
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                        }
                        HStack {
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                        }
                        HStack {
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                        }
                        HStack {
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                        }
                        HStack {
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                        }
                        HStack {
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                            ProfileBubbleView(goal: Goal(name: "Win Wimbledon", date: "Aug 234", id: 1, image: Image("fedW"), milestones: []))
                        }
                    }
                    Spacer()
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct Profile_previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
