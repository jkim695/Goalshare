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
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    @EnvironmentObject var account: Account
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    @State private var goalTitle = ""
    @State private var goalDescription = ""
    @State private var goalCompletionDate = Date()
    @State private var show = true
    @State private var complete = false
    @FocusState private var focusedBox: Bool
    @FocusState private var focusedField: FocusedField?
    @Namespace var namespace
    var body: some View {
        GeometryReader {_ in
            ZStack {
                Color.clear
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .ignoresSafeArea(.all)
                VStack(alignment: .leading) {
                    if (show) {
                        HStack() {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Cancel")
                                    .padding(20)
                            }

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
                            VStack() {
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
                    Text("          What is your Goal?")
                        .font(.headline)
                        .scaleEffect(1.5)
                    TextField("Enter goal here", text: $goalTitle, axis: .vertical)
                        .lineLimit(2...)
                        .frame(height: 70)
                        .padding()
                    VStack(alignment:.leading, spacing: 40) {
                        DatePicker("Goal Completion Date", selection: $goalCompletionDate, in: Date()..., displayedComponents: .date)
                            .padding()
                        ColorSelector(selectedColor: .red)
                            .frame(maxWidth: .infinity, alignment: .center)
                        HStack {
                            Spacer()
                            Button(action: {
                                // Check your condition here
                                var conditionIsMet = false
                                if (!goalTitle.isEmpty) {
                                    conditionIsMet = true
                                }
                                if conditionIsMet {
                                    account.goals.append(Goal(name: goalTitle, date: goalCompletionDate, image: Image("fedW")))
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
                                    .frame(alignment: .trailing)
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, keyboardObserver.keyboardHeight)
                .ignoresSafeArea(.keyboard)
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
