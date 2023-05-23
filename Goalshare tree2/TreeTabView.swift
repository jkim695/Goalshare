//
//  TreeTabView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/12/23.
//

import SwiftUI

struct TreeTabView: View {
    @EnvironmentObject var account: Account
    @Environment(\.presentationMode) var presentationMode
    @State var currentSlide: Int
    @State var animationDone = false
    @State var addingMilestone = false
    var body: some View {
        ScrollView {
            
            VStack {
                let rows = account.goals.count
                let slides = Array(stride(from: 0, to: rows, by: 1)).map { num -> AnyView in
                    AnyView(Tree().environmentObject(account.goals[num]))
                }
                HorizontalSlideshow(slides: slides, currentSlide: $currentSlide)
                    .frame(height: 1000)
            }
        }
        .background(.yellow)
    }
}


struct TreeTabView_Previews: PreviewProvider {
    static var previews: some View {
        let account2 = Account(username: "", password: "")
        account2.goals.append(contentsOf: [Goal(name: "goal1", date: Date(), color: .red), Goal(name: "goal2", date: Date(), color: .blue)])
        return VStack {
            TreeTabView(currentSlide: 0)
                .environmentObject(account2)
        }
    }
}

