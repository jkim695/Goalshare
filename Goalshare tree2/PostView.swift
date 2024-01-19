//
//  PostView.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 1/4/23.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var milestone: Milestone
    var body: some View {
        VStack {
            milestone.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .padding()
            HStack {
                Image("heart")
                Image("comment")
                Image("share")
                Spacer()
                
                
                
            }
            .offset(y: -30)
            .padding()
            HStack {
                Text(milestone.caption)
                    .font(.system(size: 18))
                Spacer()
            }
            .padding()
            .offset(y: -60)
        }
        .frame(maxHeight: .infinity)
        .background(.yellow)
                    
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
            .environmentObject(Milestone(name: "", sig: false, image: Image("fedW"), imageUrlString: "", caption: "I just won wimbledon!!"))
    }
}
