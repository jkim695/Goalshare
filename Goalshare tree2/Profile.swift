//
//  Profile.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var account: Account
    @State private var isSlideUpViewPresented = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Goals.")
                    .font(.largeTitle)
                Button(action: {
                    isSlideUpViewPresented.toggle()
                }) {
                    Text("Add goal")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                GoalDisplay()
                Spacer()
            }// Hide the back button
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .fullScreenCover(isPresented: $isSlideUpViewPresented) {
            AddGoal()
                .environmentObject(account)
        }
    }
}

struct Profile_previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(Account(username: "Filler", password: "Filler"))
    }
}
