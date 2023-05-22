//
//  EditGoalView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/17/23.
//

import SwiftUI

struct EditGoalView: View {
    @EnvironmentObject var goal: Goal
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        let name = goal.name
        let color = goal.color
        let date = goal.date
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button {
                        goal.name = name
                        goal.color = color
                        goal.date = date
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .padding(.leading, 10)
                    .foregroundColor(.black)
                    Spacer()
                    Text("Edit goal")
                        .fontWeight(Font.Weight.bold)
                        .font(.system(size: 18))
                        .kerning(0.5)
                    Spacer()
                    Button {
                        print("name: " + goal.name)
                        goal.name = goal.name
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .fontWeight(Font.Weight.semibold)
                    }
                    .padding(.trailing, 10)
                }
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                }
                .stroke(lineWidth: 0.25)
                .foregroundColor(.gray)
                .frame(height: 10)
                Circle()
                    .fill(goal.color)
                    .overlay(
                        Circle()
                            .stroke(.black, lineWidth: 2)
                    )
                    .frame(width: 110, height: 110)
                VStack{
                    HStack {
                        Text("Goal Name:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        TextField("", text: $goal.name)
                    }
                    .padding()
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                    }
                    .stroke(lineWidth: 0.25)
                    .foregroundColor(.gray)
                    .frame(height: 1)
                    HStack {
                        Text("Goal Completion Date:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        DatePicker("", selection: $goal.date, in: Date()..., displayedComponents: .date)
                    }
                    .padding()
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                    }
                    .stroke(lineWidth: 0.25)
                    .foregroundColor(.gray)
                    .frame(height: 1)
                    HStack {
                        Spacer()
                        ColorSelector(selectedColor: $goal.color)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                    }
                    .stroke(lineWidth: 0.25)
                    .foregroundColor(.gray)
                    .frame(height: 1)
                }
                Spacer()
                    .padding(.leading, 0.0)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct EditGoalView_Previews: PreviewProvider {
    static var previews: some View {
        EditGoalView()
            .environmentObject(Goal(name: "This is my goal", date: Date(), color: Color.red))
    }
}
