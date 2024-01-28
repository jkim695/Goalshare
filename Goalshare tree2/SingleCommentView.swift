//
//  SingleCommentView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 1/25/24.
//

import SwiftUI

struct SingleCommentView: View {
    @EnvironmentObject var comment: Comment
    var body: some View {
        VStack {
            HStack{
                Text(comment.username)
                    .font(.system(size: 12))
                    .bold()
                    .padding(.leading)
                Spacer()
            }
            HStack {
                Text(comment.text)
                    .font(.system(size: 14))
                    .padding(.leading)
                    .padding(.top, 0.5)
                Spacer()
            }
        }
    }
}

#Preview {
    SingleCommentView()
        .environmentObject(Comment(text: "Anyta max wynn", username: "Drake"))
}
