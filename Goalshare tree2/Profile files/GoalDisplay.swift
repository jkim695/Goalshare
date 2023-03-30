//
//  GoalDisplay.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/29/23.
//

import SwiftUI

struct GoalDisplay: View {
    @EnvironmentObject var account: Account
    var body: some View {
        VStack {
            List {
                ForEach(account.goals) { goal in
                    ProfileBubbleView(goal: goal)
                }
            }
        }
    }
}

struct GoalDisplay_Previews: PreviewProvider {
    static var previews: some View {
        GoalDisplay()
    }
}
