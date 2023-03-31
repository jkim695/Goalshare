//
//  SigMilestoneImageView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/30/23.
//

import SwiftUI

struct SigMilestoneImageView: View {
    @EnvironmentObject var milestone: Milestone
    var body: some View {
        milestone.image
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.cyan, lineWidth: 5)
            }
    }
}

struct SigMilestoneImageView_Previews: PreviewProvider {
    static var previews: some View {
        SigMilestoneImageView()
            .environmentObject(Milestone(name: "", sig: false, image: Image("fedW"), date: "", caption: ""))
    }
}
