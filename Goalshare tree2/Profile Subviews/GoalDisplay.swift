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
        ScrollView {
            let rows = (account.goals.count + 1) / 2
            ForEach(Array(stride(from: 0, to: rows, by: 1)), id: \.self) { rowIndex in
                HStack(alignment: .center, spacing: 55) {
                    ForEach(0..<2) { columnIndex in
                        if rowIndex * 2 + columnIndex < account.goals.count {
                            GoalView(index: rowIndex * 2 + columnIndex)
                                .environmentObject(account)
                        }
                    }
                }
            }
            
            Spacer()
            
                .offset(y: 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct GoalDisplay_Previews: PreviewProvider {
    static var previews: some View {
        var account: Account = Account(username: "", password: "")
        VStack {
            GoalDisplay()
                .environmentObject(account)
            Button {
                account.goals.append(Goal(name: "Filler", date: Date(), color: Color.red))
            } label: {
                Text("add goal")
            }
        }
        
    }
}
