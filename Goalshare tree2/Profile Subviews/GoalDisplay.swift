//
//  GoalDisplay.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/29/23.
//

import SwiftUI

struct GoalDisplay: View {
    @EnvironmentObject var account: Account
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ForEach(0..<(account.goals.count + 1) / 2) { rowIndex in
                HStack(spacing: 20) {
                    ForEach(0..<2) { columnIndex in
                        if rowIndex * 2 + columnIndex < account.goals.count {
                            ProfileBubbleView()
                                .environmentObject(account.goals[rowIndex * 2 + columnIndex])
                        } else {
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
}

struct GoalDisplay_Previews: PreviewProvider {
    static var previews: some View {
        GoalDisplay()
            .environmentObject(Account(username: "", password: ""))
    }
}
