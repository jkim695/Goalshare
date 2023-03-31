//
//  PostView.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 1/4/23.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var milestone: Milestone
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
        PostView()
            .environmentObject(Milestone(name: "", sig: false, image: Image("fedW"), date: "", caption: ""))
    }
}
