import SwiftUI

struct MilestoneChain: View {
    @EnvironmentObject var goal: Goal
    
    var body: some View {
        VStack (alignment: .center, spacing: 40) {
            ForEach(0..<goal.milestones.count, id: \.self) { index in
                NavigationLink {
                    PostView()
                        .environmentObject(goal.milestones[goal.milestones.count - 1 - index])
                } label: {
                    MilestoneImageView()
                        .environmentObject(goal.milestones[goal.milestones.count - 1 - index])
                }
            }
        }
    }
}

struct MilestoneChain_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack {
                let goal = Goal(name: "", date: Date(), color: Color.red)
                MilestoneChain()
                    .environmentObject(goal)
                Button {
                    goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), caption: "won"))
                } label: {
                    Text("click")
                }
            }
        }

        
    }
}
