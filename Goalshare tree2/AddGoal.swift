//
//  AddGoal.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 12/20/22.
//

import SwiftUI
import Foundation

struct AddGoal: View {
    @State private var goalTitle = ""
    @State private var goalDescription = ""
    @State private var goalCompletionDate = Date()
    @State private var goals = [Goal2]()
    @State private var showingAlert = false
    @Namespace var namespace
    @State var show = true

    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("What is your Goal?")) {
                        TextField("Goal Title", text: $goalTitle)
                        TextField("Goal Description", text: $goalDescription)
                        DatePicker("Goal Completion Date", selection: $goalCompletionDate, in: Date()..., displayedComponents: .date)
                    }
                    
                    Section {
                        Button(action: {
                            self.goals.append(Goal2(title: self.goalTitle, description: self.goalDescription, completionDate: self.goalCompletionDate))
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
                VStack() {
                    if (show) {
                        HStack() {
                            Spacer()
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(20)
                                .bold()
                        }
                        .offset(y: -25)
                        Spacer()
                    }
                    else {
                        VStack (alignment: .trailing, spacing: 12){
                            ZStack() {
                                Image("fedW")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                                    .cornerRadius(20)
                                
                                VStack {
                                    Text("Criteria for a good goal:")
                                        .padding()
                                    Text("1) Is the goal SPECIFIC?")
                                    Text("2) Is the goal MEASURABLE?")
                                    Text("3) Is the goal ATTAINABLE?")
                                    Text("4) Is the goal RELEVANT?")
                                    Text("5) Is the goal TIMELY?")
                                }
                                .foregroundColor(.white)
                            }
                        }
                    }
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        show.toggle()
                    }
                }
            
                }
            }
            .navigationBarTitle("Add Goal")
        }
    }

struct Goal2: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var completionDate: Date
}

struct GoalDetailView: View {
    var goal: Goal2

    var body: some View {
        ZStack {
            var milestones: [Milestone] = []
            Tree(goal: Goal(name: "hi", date: "Aug", id: 1, image: Image("fedW"), milestones: milestones))
//            Text(goal.title)
//            Text("Description: \(goal.description)")
//            Text("Completion Date: \(goal.completionDate)")
            Spacer()
        }.navigationBarTitle(goal.title, displayMode: .inline)
            
    }
}

struct AddGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddGoal()
    }
}
