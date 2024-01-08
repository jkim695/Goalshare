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
        if let image = milestone.image {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 132, height: 132)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(color, lineWidth: 4)
                }
                .onAppear {
                    if milestone.image == nil {
                        milestone.loadImage()
                    }
                }
        }
        else {
            Circle()
                .fill(.red)
                .frame(width: 150, height: 150)
                .onAppear {
                    if milestone.image == nil {
                        milestone.loadImage()
                    }
                }
        }
    }
}

struct MilestoneImageView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneImageView()
            .environmentObject(Milestone(name: "", sig: true, image: Image("fedW"), imageUrlString:  "", caption: ""))
    }
}
