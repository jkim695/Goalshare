//
//  PostView.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 1/4/23.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var account: Account
    @State var goal_index: Int
    @State var milestone_index: Int
    @State var liked = false
    var body: some View {
        let milestone = account.goals[goal_index].milestones[milestone_index]
        if (account.likedPhotos.likedPhotos.contains(milestone.id.uuidString)) {
            liked = true
        }
        return VStack {
            milestone.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .padding()
            HStack {
                Button(action: {
                    liked.toggle()
                    if (liked) {
                        account.likedPhotos.likedPhotos.append(milestone.id.uuidString)
                    } else {
                        account.likedPhotos.likedPhotos.removeAll(where: {$0 == milestone.id.uuidString})
                    }
                }) {
                    if (!liked) {
                        Image("not_liked_heart")
                            .resizable()
                            .frame(width: 30, height: 30)
                    } else {
                        Image("liked_heart")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                    }
                }
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
        let account = Account(id: "", goals: [])
        let goal = Goal(id: "",name: "", date: Date(), pin: false)
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        account.goals.append(goal)
        return PostView(goal_index: 0, milestone_index: 2)
            .environmentObject(account)
    }
}
