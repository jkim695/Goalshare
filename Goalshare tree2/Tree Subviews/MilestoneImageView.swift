//
//  MilestoneImageView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/30/23.
//

import SwiftUI

struct MilestoneImageView: View {
    @EnvironmentObject var milestone: Milestone
    var body: some View {
        milestone.image
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
    }
}

struct MilestoneImageView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneImageView()
            .environmentObject(Milestone(name: "", sig: false, image: Image("fedW"), date: "", caption: ""))
    }
}
