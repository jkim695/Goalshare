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
            
            VStack(spacing: 0){
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
                .frame(height: 45.0)
                // Color maybe dark yellow
                .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .bottom).foregroundColor(Color.black), alignment: .bottom)
                ScrollView {
                    VStack(spacing: 50) {
                        ForEach(1..<10) {
                            Text("Grandslam winner \($0)")
                            Image("overlook-autumn")
                                .resizable()
                                .cornerRadius(15.0)
                                .padding([.leading, .bottom, .trailing], 29.0)
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
