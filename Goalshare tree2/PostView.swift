//
//  PostView.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 1/4/23.
//

import SwiftUI

struct PostView: View {
    var milestone: Milestone
    var body: some View {
        VStack {
            milestone.image
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(milestone.date)
            Text(milestone.caption)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(milestone: Milestone(sig: true, id: 1, name: "FED", date: "Aug 10", imageName: "fedW", caption: "Won my first tennis tournament!"))
    }
}
