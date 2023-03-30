//
//  AddGoal.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 12/20/22.
//

import SwiftUI
import Foundation

struct AddGoal: View {
    @EnvironmentObject var account: Account
    @State private var goalTitle = ""
    @State private var goalDescription = ""
    @State private var goalCompletionDate = Date()
    @State private var show = true
    @State private var complete = false
    @Namespace var namespace
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("What is your Goal?")) {
                        TextField("Goal Title", text: $goalTitle)
                        TextField("Goal Description", text: $goalDescription)
                        DatePicker("Goal Completion Date", selection: $goalCompletionDate, in: Date()..., displayedComponents: .date)
                    }
                }
                NavigationLink(destination: Profile().onAppear(perform: {
                    account.goals.append(Goal(name: goalTitle, date: goalCompletionDate, image: Image("fedW")))
                }), isActive: $complete) {
                    EmptyView()
                }
                Button(action: {
                    // Check your condition here
                    var conditionIsMet = false
                    if (!goalTitle.isEmpty && !goalDescription.isEmpty) {
                        conditionIsMet = true
                    }
                    if conditionIsMet {
                        complete = true
                    } else {
                        print("Condition not met")
                    }
                }) {
                    Text("Navigate")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
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

struct AddGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddGoal()
            .environmentObject(Account(username: "", password: ""))
    }
}
