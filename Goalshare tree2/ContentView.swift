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
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    Spacer()
                    Text("GoalShare.")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 60.0)
                    //                    Image(systemName: "tree")
                    //                        .imageScale(.large)
                    //                        .foregroundColor(.black)
                    Spacer()
                    Button {
                        print("monkey")
                    } label: {
                        Image(systemName: "person.circle")
                            .foregroundColor(Color.black)
                            .padding(.trailing, 11.0)
                            .font(.system(size: 32.0))
                    }
                }
                ScrollView {
                    VStack(spacing: 50) {
                        ForEach(1..<10) {
                            Text("Grandslam winner \($0)")
                            Image("overlook-autumn")
                                .resizable()
                                .padding(.all, 29.0)
                                .cornerRadius(9)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainFeed()
    }
}
