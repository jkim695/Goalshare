//
//  Profile.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("tree")
                    .resizable()
                .aspectRatio(contentMode: .fill)
                Spacer()
                NavigationLink(destination: AddGoal(), label: {
                    Text("Add Goal")
                        .foregroundColor(Color.black)
                        .font(.system(size: 22.0))
                        .frame(width: 100)
                        .background(.white)
                        .cornerRadius(15)
                    }
                )
                .offset(x: 50, y: 390)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct Profile_previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
