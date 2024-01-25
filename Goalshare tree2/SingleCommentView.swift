//
//  SingleCommentView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 1/25/24.
//

import SwiftUI

struct SingleCommentView: View {
    @EnvironmentObject var account: Account
    var body: some View {
        VStack {
            HStack{
                Text(account.username)
                    .font(.system(size: 12))
                    .bold()
                    .padding(.leading)
                Spacer()
            }
            HStack {
                Text("Anita max wynn!")
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
        .environmentObject(Account(id: "", goals: [], username: "Drake"))
}
