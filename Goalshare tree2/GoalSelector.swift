//
//  GoalSelector.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/17/23.
//

import SwiftUI

struct GoalSelector: View {
    @EnvironmentObject var account: Account
    @State var selectedGoalIndex: Int = 0
    @State var showing: Bool = false
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
                        selectedGoalIndex = index
                        showing = true
                    }) {
                        Text(account.goals[index].name)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showing) {
            EditGoalView(index: selectedGoalIndex, goalDate: account.goals[selectedGoalIndex].date)
                .environmentObject(account)
        }
    }
}

struct GoalSelector_Previews: PreviewProvider {
    static var previews: some View {
        GoalSelector()
            .environmentObject(Account(id: "", username: "Federer"))
    }
}
