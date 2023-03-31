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
                goal.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay {
                    Circle().stroke(.gray, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .frame(width: 175)
            }
            Text(goal.name)
        }
    }
}

struct ProfileBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBubbleView()
            .environmentObject(Goal(name: "Win Wimbledon", date: Date(), image: Image("fedW")))
    }
}
