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
            Image(uiImage: milestone.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .padding()
            Text(milestone.date)
            Text(milestone.caption)
                .font(.system(size: 25))
        }
        .frame(maxHeight: .infinity)
        .background(.yellow)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
            .environmentObject(Milestone(name: "", sig: false, date: "", caption: "I just won wimbledon!!", image: UIImage(named: "fedW")!))
    }
}
