//
//  PapaClass.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI

struct PapaClass: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center) {
                    Text("GoalShare.")
                        .font(.largeTitle)
                        .offset(x:30)
                    NavigationLink(destination: Profile(), label: {
                        Image(systemName: "person.circle")
                            .foregroundColor(Color.black)
                            .font(.system(size: 32.0))
                        }
                    )
                    .offset(x:90)
                }
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
                MainFeed()
                    .offset(y:-25)
                    .ignoresSafeArea()
            }
        }
    }
}

struct PapaClass_Previews: PreviewProvider {
    static var previews: some View {
        PapaClass()
    }
}
