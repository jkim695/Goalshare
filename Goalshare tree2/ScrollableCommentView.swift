//
//  ScrollableCommentView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 1/25/24.
//

import SwiftUI

struct ScrollableCommentView: View {
    @EnvironmentObject var milestone: Milestone
    var body: some View {
        ScrollView(.vertical) {
            ForEach(Array(stride(from: 0, to: milestone.comments.count, by: 1)), id: \.self) { rowIndex in
                SingleCommentView()
                    .environmentObject(milestone.comments[rowIndex])
                    .padding(.top, 5)
            }

        }
    }
}

#Preview {
    let milestone = Milestone(name: "", sig: false, image: Image("fedW"), imageUrlString: "jf", caption: "hi")
    milestone.comments.append(Comment(text: "Anyta max wynn", username: "Drake"))
    milestone.comments.append(Comment(text: "Anyta max wynn", username: "Drake"))
    return ScrollableCommentView()
        .environmentObject(milestone)
}
