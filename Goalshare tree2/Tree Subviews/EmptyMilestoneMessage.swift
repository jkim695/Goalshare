//
//  EmptyMilestoneMessage.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/30/23.
//

import SwiftUI

struct EmptyMilestoneMessage: View {
    var body: some View {
        VStack {
            Text("No Milestones yet")
                .foregroundColor(.black)
            Text("Click the + to add one!")
                .foregroundColor(.black)
        }
    }
}

struct EmptyMilestoneMessage_Previews: PreviewProvider {
    static var previews: some View {
        EmptyMilestoneMessage()
    }
}
