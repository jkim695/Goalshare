//
//  PostView.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 1/4/23.
//

import SwiftUI
import FirebaseFirestore

struct PostView: View {
    @EnvironmentObject var account: Account
    @State var goal_index: Int
    @State var milestone_index: Int
    @State var liked = false
    @State var doubleTapped = false
    @State var scale = 1.0
    @State var opacity = 0.0
    var body: some View {
        let milestone = account.goals[goal_index].milestones[milestone_index]
        return VStack {
            ZStack {
                milestone.image?
                    .resizable()
                    .frame(width: 350, height: 250)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .padding()
                    .onTapGesture (count: 2) {
                        if (!liked) {
                            account.likedPhotos.likedPhotos.append(milestone.id)
                        }
                        liked = true
                        doubleTapped = true
                    }
                if (doubleTapped) {
                    Image("liked_heart")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .scaleEffect(scale)
                        .onAppear {
                            scale = 3.0
                            opacity = 1.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.bouncy(duration: 1)) {
                                    opacity = 0.0
                                    scale = 1.0
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                doubleTapped = false
                            }

                        }
                        .opacity(opacity)
                        .animation(.linear(duration: 0.15), value: scale)
                }
            }
            HStack {
                Button(action: {
                    liked.toggle()
                    if (liked) {
                        account.likedPhotos.likedPhotos.append(milestone.id)
                    } else {
                        account.likedPhotos.likedPhotos.removeAll(where: {$0 == milestone.id})
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
                .onAppear {
                    if (account.likedPhotos.likedPhotos.contains(milestone.id)) {
                        liked = true
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
                    .foregroundColor(.black)
                    .font(.system(size: 18))
                Spacer()
            }
            .padding()
            .offset(y: -60)
        }
        .frame(maxHeight: .infinity)
        .background(.yellow)
                    
    }
    
    func updateLikeStatus(_ liked: Bool, for id: String) {
        let db = Firestore.firestore()
        db.collection("accounts").document(account.id).collection("goals").document(account.goals[goal_index].id!).collection("milestones").document(account.goals[goal_index].milestones[milestone_index].id).updateData([
            "liked": liked
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        let account = Account(id: "", goals: [], username: "Federer")
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
