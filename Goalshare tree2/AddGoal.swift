//
//  AddGoal.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 12/20/22.
//

import SwiftUI

struct ChatGPT: View {
    @State private var goalTitle = ""
    @State private var goalDescription = ""
    @State private var goalCompletionDate = Date()
    @State private var goals = [Goal]()
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("What is your Goal?")) {
                        TextField("Goal Title", text: $goalTitle)
                        TextField("Goal Description", text: $goalDescription)
                        DatePicker("Goal Completion Date", selection: $goalCompletionDate, in: Date()..., displayedComponents: .date)
                    }

                    Section {
                        Button(action: {
                            self.goals.append(Goal(title: self.goalTitle, description: self.goalDescription, completionDate: self.goalCompletionDate))
                            self.showingAlert = true
                        }) {
                            Text("Create Goal")
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Success!"), message: Text("You have created a new goal!"), dismissButton: .default(Text("OK")))
                        }
                    }

                    Section(header: Text("My Goals")) {
                        List {
                            ForEach(goals) { goal in
                                NavigationLink(destination: GoalDetailView(goal: goal)) {
                                    Text(goal.title)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Goals")
        }
    }
}

struct Goal: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var completionDate: Date
}

struct GoalDetailView: View {
    var goal: Goal

    var body: some View {
        ZStack {
            Tree()
//            Text(goal.title)
//            Text("Description: \(goal.description)")
//            Text("Completion Date: \(goal.completionDate)")
            Spacer()
        }.navigationBarTitle(goal.title, displayMode: .inline)
            
    }
}

struct ChatGPT_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPT()
    }
}
