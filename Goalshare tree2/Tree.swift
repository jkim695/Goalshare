//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/24/22.
//

import SwiftUI

struct Tree: View {
    @EnvironmentObject var goal: Goal
    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all) // Set the background color to yellow
                VStack {
                    NavigationLink(destination: AddMilestone().environmentObject(goal),
                                   label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width:25, height:25)
                    })
                    .foregroundColor(.blue)
                    .offset(x: 150)
                    ScrollView(.vertical) {
                        VStack {
                            Text(goal.name)
                                .font(.largeTitle.bold())
                            if (goal.milestones.isEmpty) {
                                EmptyMilestoneMessage()
                            }
                            else {
                                MilestoneChain()
                                    .environmentObject(goal)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}





