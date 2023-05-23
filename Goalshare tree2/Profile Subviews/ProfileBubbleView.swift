//
//  ProfileBubbleView.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 2/22/23.
//

import SwiftUI

struct ProfileBubbleView: View {
    @EnvironmentObject var account: Account
    @State var index: Int
    var body: some View {
        VStack {
            NavigationLink {
                TreeTabView(currentSlide: index)
                    .environmentObject(account)
            }
            label: {
                Circle()
                    .fill(account.goals[index].color)
                    .overlay(
                        Circle()
                            .stroke(.black, lineWidth: 2)
                    )
                    .frame(width: 110, height: 110)
                
            }
            Text(account.goals[index].name)
                .font(.system(size: 13))
        }
    }
}

struct ProfileBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        let account = Account()
        account.goals.append(Goal(name: "this is a goal", date: Date(), color: .red))
        return ProfileBubbleView(index: 0)
            .environmentObject(account)
    }
}
