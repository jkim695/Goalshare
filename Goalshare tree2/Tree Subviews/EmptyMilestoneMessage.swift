//
//  EmptyMilestoneMessage.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/30/23.
//

import SwiftUI

struct EmptyMilestoneMessage: View {
    var body: some View {
        Text("No Milestones yet")
            .offset(y:300)
        Text("Click the + to add one!")
            .offset(y:300)
    }
}

struct EmptyMilestoneMessage_Previews: PreviewProvider {
    static var previews: some View {
        EmptyMilestoneMessage()
    }
}
