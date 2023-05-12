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
    @State var currentSlide = 0
    @State var animationDone = false
    @State var addingMilestone = false
    var body: some View {
        ScrollView {
            
            VStack {
                let rows = account.goals.count
                let slides = Array(stride(from: 0, to: rows, by: 1)).map { num -> AnyView in
                    AnyView(Tree().environmentObject(account.goals[num]))
                }
                ZStack {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "house.circle")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding()
                        }
                        Spacer()
                    }
                    HStack (spacing: 20) {
                        Spacer()
                        ShareLink(item: /*@START_MENU_TOKEN@*/URL(string: "https://developer.apple.com/xcode/swiftui")!/*@END_MENU_TOKEN@*/)
                        {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .frame(width: 23, height: 32)
                        }
                        Button(action: {
                            addingMilestone = true
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width:25, height:25)
                        }
                        .navigationDestination(for: Int.self) { int in
                            AddMilestone().environmentObject(account.goals[currentSlide])
                        }
                    }
                }
                .padding(.trailing)
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
            TreeTabView()
                .environmentObject(account2)
        }
    }
}

