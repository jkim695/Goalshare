//
//  GoalSelector.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/17/23.
//

import SwiftUI

struct GoalSelector: View {
    @EnvironmentObject var account: Account
    @State var selectedGoal: Goal?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                }
                .padding(.trailing, 10)

            }
            List {
                ForEach(account.goals.indices, id: \.self) { index in
                    Button(action: {
                        selectedGoal = account.goals[index]
                    }) {
                        Text(account.goals[index].name)
                    }
                }
            }
        }
        .fullScreenCover(item: $selectedGoal) { goal in
            EditGoalView()
                .environmentObject(goal)
        }
    }
}

struct GoalSelector_Previews: PreviewProvider {
    static var previews: some View {
        GoalSelector()
            .environmentObject(Account(username: "", password: ""))
    }
}
