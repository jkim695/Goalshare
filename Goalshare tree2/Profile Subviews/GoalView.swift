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
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(changeColor2 ? .purple : .red)
                        .scaleEffect(changeColor2 ? 1.0 : 0.9)
                        .offset(x: 62, y: -62)
                        .opacity(showSubCircles ? 1 : 0)
                        .animation(.easeInOut(duration: 0.25), value: showSubCircles)
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width:20, height: 20)
                        .offset(x: 70.5, y: -70.5)
                        .opacity(showSubCircles ? 1 : 0)
                        .scaleEffect(changeColor2 ? 0.95 : 0.9)
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(changeColor1 ? .purple : .red)
                        .scaleEffect(changeColor1 ? 1.0 : 0.9)
                        .offset(x: 62, y: 62)
                        .opacity(showSubCircles ? 1 : 0)
                        .animation(.easeInOut(duration: 0.25), value: showSubCircles)
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width:22, height: 25)
                        .offset(x: 70.5, y: 70.5)
                        .opacity(showSubCircles ? 1 : 0)
                        .scaleEffect(changeColor1 ? 0.95 : 0.9)
                    Circle()
                        .frame(width: 161, height: 161)
                        .foregroundColor(account.goals[index].color)
                        .scaleEffect(isPressed ? 1.0 : 0.9)
                        .overlay(
                            Circle()
                                .stroke(.black, lineWidth: 2)
                                .scaleEffect(isPressed ? 1.0 : 0.9)
                        )
                        .animation(.easeInOut, value: isPressed)
                        .shadow(color: Color.black.opacity(0.4), radius: 3.3, x: 0, y: 2)
                    NavigationLink(destination: TreeTabView(currentSlide: index).environmentObject(account), isActive: $isTapped) {
                        EmptyView()
                    }
                }
                Text(account.goals[index].name)
                    .font(.custom("Lexend-Regular", size: 16))
            }
            .fullScreenCover(isPresented: $link1, content: {
                EditGoalView()
                    .environmentObject(account.goals[index])
            })
            .fullScreenCover(isPresented: $link2, content: {
                AddMilestone()
                    .environmentObject(account.goals[index])
            })
            .animation(.easeInOut, value: changeColor)
            .gesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onChanged { _ in
                        isPressed = true
                        isLongPress = true
                    }
                    .onEnded { _ in
                        if isLongPress {
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                            showSubCircles = true
                        }
                    }
                    .simultaneously(with: DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            isPressed = true
                            if abs(value.translation.height) > 50 && value.translation.width > 30 {
                                changeColor = true
                                if value.translation.height > 0 {
                                    changeColor1 = true
                                }
                                else {
                                    changeColor2 = true
                                }
                                
                            }
                            else {
                                changeColor = false
                                changeColor1 = false
                                changeColor2 = false
                            }
                        }
                        .onEnded { value in
                            isPressed = false
                            isLongPress = false
                            showSubCircles = false
                            if abs(value.translation.height) > 50 && value.translation.width > 30 {
                                if value.translation.height > 0 {
                                    link1 = true
                                }
                                else {
                                    link2 = true
                                }
                                
                            }
                        }
                    )
                    .simultaneously(with: TapGesture()
                        .onEnded { _ in
                            isTapped = true
                        }
                    )
            )
            
        }
    }





struct GoalView_preview: PreviewProvider {
    static var previews: some View {
        let account = Account(username: "", password: "")
        account.goals.append(Goal(name: "Win Wimbledon and Win everything", date: Date(), color: Color.green))
        account.goals.append(Goal(name: "win", date: Date(), color: Color.red))
        account.goals.append(Goal(name: "win", date: Date(), color: Color.red))
        return GoalView(index: 0)
            .environmentObject(account)
    }
}
