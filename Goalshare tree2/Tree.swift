//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/24/22.
//

import SwiftUI

struct Tree: View {
    @EnvironmentObject var goal: Goal
    @Environment(\.presentationMode) var presentationMode
    @State private var offset: CGFloat = 0
    @State private var atTopOfScrollView = true

    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all) // Set the background color to yellow
                VStack {
                    HStack (spacing: 25) {
                        Text(goal.name)
                            .font(.largeTitle.bold())
                        ShareLink(item: /*@START_MENU_TOKEN@*/URL(string: "https://developer.apple.com/xcode/swiftui")!/*@END_MENU_TOKEN@*/)
                            {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .frame(width: 23, height: 32)
                            }
                        NavigationLink(destination: AddMilestone().environmentObject(goal),
                                       label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width:25, height:25)
                        })
                        .foregroundColor(.blue)
                    }
                    .offset(x: CGFloat(130 - goal.name.count * 10))
                    ScrollView(.vertical) {
                        GeometryReader { geometryProxy in
                            Color.clear.preference(key: ScrollViewTopPreferenceKey.self, value: geometryProxy.frame(in: .named("scrollView")).minY)
                        }
                        VStack(spacing: 20) {
                            if (goal.milestones.isEmpty) {
                                EmptyMilestoneMessage()
                            }
                            else {
                                ZStack {
                                    Path { path in
                                        path.move(to: CGPoint(x: 210, y: 0))
                                        path.addLine(to: CGPoint(x: 210, y: 150 * goal.milestones.count))
                                    }
                                    .stroke(Color.black, lineWidth: 15)
                                    MilestoneChain()
                                        .environmentObject(goal)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .coordinateSpace(name: "scrollView")
                    .onPreferenceChange(ScrollViewTopPreferenceKey.self) { value in
                        atTopOfScrollView = value > -5
                    }
                    .frame(maxWidth: .infinity)
                    .offset(y: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if atTopOfScrollView && value.translation.height > 0 {
                                    self.offset = value.translation.height
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > 10 {
                                    self.presentationMode.wrappedValue.dismiss()
                                } else {
                                    withAnimation {
                                        self.offset = 0
                                    }
                                }
                            }
                    )
                }
            }
        }
    }
}

private struct ScrollViewTopPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct Trees_Previews: PreviewProvider {
    static var previews: some View {
        // add to array to test previews to lazy todo now
        Tree()
            .environmentObject(Goal(name: "", date: Date(), image: Image("fedW")))
    }
}





