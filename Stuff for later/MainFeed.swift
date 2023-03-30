//
//  ContentView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/19/22.
//

import SwiftUI

struct MainFeed: View {
    var body: some View {
        ZStack {
            Color(.systemYellow)
            ScrollView {
                VStack(spacing: 40) {
                    ForEach(1..<10) {
                        Text("Grandslam winner \($0)")
                        Image("overlook-autumn")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}


struct MainFeed_previews: PreviewProvider {
    static var previews: some View {
        MainFeed()
    }
}
