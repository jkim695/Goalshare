//
//  GoalView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/21/23.
//


import SwiftUI
struct GoalView: View {
    @EnvironmentObject var account: Account
    @State var index: Int
    @State private var isPressed = false
    @State private var showSubCircles = false
    @State private var isLongPress = false
    @State private var dragThresholdPassed = false
    @State private var changeColor = false
    @State private var changeColor1 = false
    @State private var changeColor2 = false
    @State private var link1 = false
    @State private var link2 = false
    @State private var isTapped = false
    
    var body: some View {
        VStack {
            ZStack {
                if account.goals[index].milestones.count == 0 {
                    Image("default_goal_icon") // To be changed to an image loaded in from firebase storage!!
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 132, height: 132)
                        .overlay(
                            Circle()
                                .stroke(.black, lineWidth: 4)
                        )
                }
                else {
                    MilestoneImageView()
                        .environmentObject(account.goals[index].milestones[account.goals[index].milestones.count - 1])
                }
                
                
                NavigationLink(destination: TreeTabView(currentSlide: index).environmentObject(account), isActive: $isTapped) {
                    EmptyView()
                }
                
                
            }
            .onTapGesture {
                isTapped = true
            }
            Text(account.goals[index].name)
                .font(.custom("Lexend-Regular", size: 16))
                .frame(width: 180)
        }
    }
}





struct GoalView_preview: PreviewProvider {
    static var previews: some View {
        let account = Account(id: " ")
        account.goals.append(Goal(id: "",name: "Win Wimbledon and Win everything", date: Date(), pin: false))
        account.goals.append(Goal(id: "",name: "win", date: Date(), pin: false))
        account.goals.append(Goal(id: "",name: "win", date: Date(), pin: false))
        return GoalView(index: 0)
            .environmentObject(account)
    }
}
