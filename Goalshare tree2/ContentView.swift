//
//  ContentView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/19/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemYellow)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("GOALSHARE")
                        .font(.title)
                        .fontWeight(.bold)
                    Image(systemName: "tree")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Image("fedW")
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
