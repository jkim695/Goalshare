//
//  MilestoneImageView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/30/23.
//

import SwiftUI

struct MilestoneImageView: View {
    @EnvironmentObject var milestone: Milestone
    var color: Color {
        if milestone.sig {
            return .cyan
        } else {
            return .black
        }
    }
    var body: some View {
        HStack(alignment: .center) {
            milestone.image
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(color, lineWidth: 4)
                }
        }
    }
}

struct MilestoneImageView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneImageView()
            .environmentObject(Milestone(name: "", sig: true, image: Image("fedW"), date: "08/08/2023", caption: ""))

    }
}
