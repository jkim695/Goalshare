import SwiftUI

struct MilestoneChain: View {
    @EnvironmentObject var goal: Goal
    
    var body: some View {
        Color.clear
            .overlay (GeometryReader { geometry in
                ScrollView {
                    VStack (alignment: .center, spacing: 20) {
                        ForEach(0..<goal.milestones.count, id: \.self) { index in
                            HStack {
                                NavigationLink {
                                    PostView()
                                        .environmentObject(goal.milestones[goal.milestones.count - 1 - index])
                                } label: {
                                    MilestoneImageView()
                                        .environmentObject(goal.milestones[goal.milestones.count - 1 - index])
                                }
                                Text(goal.milestones[goal.milestones.count - 1 - index].date, style: .date)
                                    .frame(width: 150)
                                    .font(.system(size: 16))
                                    .bold()
                            }
                            .frame(maxWidth: .infinity)
                            if index < goal.milestones.count - 1 {
                                GeometryReader { geometry in
                                    Path { path in
                                        path.move(to: CGPoint(x: geometry.size.width/2 - 80, y: -20))
                                        path.addLine(to: CGPoint(x: geometry.size.width/2 - 80, y: 28))
                                    }
                                    .stroke(Color.black, lineWidth: 15)
                                }
                            }
                        }
                    }
                }
                .padding()

                .clipped()
            }
                .ignoresSafeArea()

                      
            )
    }
    
}

struct MilestoneChain_Previews: PreviewProvider {
    static var previews: some View {
        let goal = Goal(id: "",name: "", date: Date(), pin: false)
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrlString: "", caption: "won"))
        return VStack {
            MilestoneChain()
                .environmentObject(goal)
            
        }
        
        
        
    }
}
