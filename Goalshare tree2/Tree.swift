//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/24/22.
//

import SwiftUI
import FirebaseAnalyticsSwift

struct Tree: View {
    @State var index: Int?
    @EnvironmentObject var account: Account
    @Environment(\.presentationMode) var presentationMode
    @State private var offset: CGFloat = 0
    @State private var atTopOfScrollView = true
    @State private var addingMilestone = false
    
    init(index: Int) {
        self._index = State(initialValue: index)  // Use the underlying `_` variable to set initial value
        
        if let fontURL = Bundle.main.url(forResource: "Futura", withExtension: "ttc") {
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)
        } else {
            print("Error: Futura font file not found.")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all) // Set the background color to yellow
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrowshape.left.fill")
                                    .resizable()
                                    .frame(width: 18, height: 15)
                                    .foregroundColor(.gray)
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
                                    .frame(width: 15, height: 20)
                                    .foregroundColor(.gray)
                            }
                            Button(action: {
                                addingMilestone = true
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width:15, height:15)
                                    .foregroundColor(.gray)
                            }
                            .navigationDestination(for: Int.self) { int in
                                AddMilestone(index: index!).environmentObject(account)
                            }
                        }
                        HStack (alignment: .center) {
                            Spacer()
                            Text(account.goals[index!].name)
                                .font(.custom("Futura", size: 20))
                            Spacer()
                        }
                    }
                    .padding(.trailing)
                        if (account.goals[index!].milestones.isEmpty) {
                            EmptyMilestoneMessage()
                        }
                        else {
                            MilestoneChain()
                                .environmentObject(account.goals[index!])
                            
                        }
                    
                    Spacer()
                }
            }
        }
        .fullScreenCover(isPresented: $addingMilestone) {
            AddMilestone(index: index!)
                .environmentObject(account.goals[index!])
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
        .navigationBarBackButtonHidden(true)
        .analyticsScreen(name: "\(Tree.self)")
    }
}

struct Trees_Previews: PreviewProvider {
    static var previews: some View {
        let account = Account(id: "")
        account.goals.append(Goal(id: "",name: "Develop this app", date: Date(), pin: false))
        return Tree(index: 0)
            .environmentObject(account)
    }
}





