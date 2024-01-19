//
//  PostView_Template.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 1/12/24.
//

import SwiftUI

struct PostView_Template: View {
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
            // to add back
//            HStack {
//                Text(milestone.caption)
//                    .font(.system(size: 18))
//                Spacer()
//            }
//            .padding()
//            .offset(y: -60)
            
            // sample for figma
            HStack {
                Text("After 20 years of hard work and trials and tribulations, I've finally accomplished my goal of winning on hard court and grass. I want to say thank you to all my followers on goalshare that supported me through this journey. I couldn't have done it without you guys. - Roger")
                    .font(.system(size: 18))
                Spacer()
            }
            .padding()
            .offset(y: -60)
            HStack {
                Text("View 999+ more comments")
                    .font(.system(size: 18))
                    .opacity(0.5)
                Spacer()
            }
            .padding()
            .offset(y: -85)
            HStack {
                Text("Great job Roger!! - Medvedev")
                    .font(.system(size: 18))
                Spacer()
            }
            .padding()
            .offset(y: -115)
            HStack {
                Text("I'm coming for the crown! - Kyrigios")
                    .font(.system(size: 18))
                Spacer()
            }
            .padding()
            .offset(y: -145)
            
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(.yellow)
    }
}

#Preview {
    PostView_Template()
        .environmentObject(Milestone(name: "", sig: false, image: Image("fedW"), imageUrlString: "", caption: "I just won wimbledon!!"))
}
