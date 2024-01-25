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
                HStack(alignment: .center, spacing: 2) {
                    ForEach(0..<2) { columnIndex in
                        if rowIndex * 2 + columnIndex < account.goals.count {
                            GoalView(index: rowIndex * 2 + columnIndex)
                                .environmentObject(account)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .onTapGesture {
            
        }
    }
}

struct GoalDisplay_Previews: PreviewProvider {
    static var previews: some View {
        var account: Account = Account(id: "", username: "Federer")
        VStack {
            GoalDisplay()
                .environmentObject(account)
            Button {
                account.goals.append(Goal(id: "", name: "Filler", date: Date(), pin: false))
            } label: {
                Text("add goal")
            }
        }
        
    }
}
