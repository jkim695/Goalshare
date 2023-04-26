//
//  ProfileBubbleView.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 2/22/23.
//

import SwiftUI

struct ProfileBubbleView: View {
    @EnvironmentObject var goal: Goal
    var body: some View {
        VStack {
            NavigationLink {
                Tree()
                    .environmentObject(goal)
            }
            label: {
                Circle()
                    .fill(goal.color)
                    .overlay(
                        Circle()
                            .stroke(.black, lineWidth: 2)
                    )
                    .frame(width: 110, height: 110)
                
            }
            Text(goal.name)
                .font(.system(size: 13))
        }
    }
}

struct ProfileBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBubbleView()
            .environmentObject(Goal(name: "Win Wimbledon", date: Date(), color: Color.red))
    }
}
