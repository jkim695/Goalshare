//
//  Profile.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var account: Account
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Goals.")
                    .font(.largeTitle)
                NavigationLink(destination: AddGoal(), label: {
                    Text("Add Goal")
                        .foregroundColor(Color.black)
                        .font(.system(size: 22.0))
                        .frame(width: 100)
                        .background(.yellow)
                        .cornerRadius(15)
                    }
                )
                GoalDisplay()
            }// Hide the back button
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Profile_previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(Account(username: "Filler", password: "Filler"))
    }
}
