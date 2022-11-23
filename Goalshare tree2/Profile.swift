//
//  Profile.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        VStack{
            Image("tree")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Text("FILLER")
                .font(.largeTitle)
        }
        .ignoresSafeArea()
    }
}

struct Profile_previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
