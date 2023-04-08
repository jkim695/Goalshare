//
//  AddGoal.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 12/20/22.
//

import SwiftUI
import Foundation

struct AddGoal: View {
    enum FocusedField {
        case goalTitle
    }
    
    @EnvironmentObject var account: Account
    @Environment(\.presentationMode) var presentationMode
    @State private var goalTitle = ""
    @State private var goalDescription = ""
    @State private var goalCompletionDate = Date()
    @State private var show = true
    @State private var complete = false
    @FocusState private var focusedField: FocusedField?
    @Namespace var namespace
    var body: some View {
        NavigationView {
            VStack(alignment:.leading, spacing: 60) {
                if (show) {
                    HStack() {
                        Spacer()
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(20)
                            .bold()
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    show.toggle()
                                }
                            }
                    }
                    .offset(y: -25)
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
                            .foregroundColor(.black)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            show.toggle()
                        }
                    }
                }
                Section(header: Text("       What is your Goal?")
                    .font(.headline)
                    .scaleEffect(1.5)
                ) {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $goalTitle)
                            .frame(height: 120)
                            .cornerRadius(8)
                            .focused($focusedField, equals: .goalTitle)
                            .onAppear {
                                focusedField = .goalTitle
                            }
                        if goalTitle.isEmpty {
                            Text("Ex. Learn how to do a backflip")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 8)
                        }
                    }
                    DatePicker("Goal Completion Date", selection: $goalCompletionDate, in: Date()..., displayedComponents: .date)
                }
                .padding()
                ColorSelector(selectedColor: .red)
                    .frame(maxWidth: .infinity, alignment: .center)
                Button(action: {
                    // Check your condition here
                    var conditionIsMet = false
                    if (!goalTitle.isEmpty) {
                        conditionIsMet = true
                    }
                    if conditionIsMet {
                        let image = UIImage(named: "fedW")
                        account.goals.append(Goal(name: goalTitle, date: goalCompletionDate, image: image!))
                        account.save()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("Condition not met")
                    }
                }) {
                    Text("Add Goal!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Spacer()
            }
        }
    }
}

struct AddGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddGoal()
            .environmentObject(Account(username: "", password: ""))
    }
}
