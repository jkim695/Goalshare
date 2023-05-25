import SwiftUI

struct MilestoneChain: View {
    @EnvironmentObject var goal: Goal
    
    var body: some View {
        VStack (alignment: .center, spacing: 40) {
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
                        .font(.system(size: 10))
                }
            }
        }
    }
}

struct MilestoneChain_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack {
                let goal = Goal(name: "", date: Date(), pin: false)
                MilestoneChain()
                    .environmentObject(goal)
                Button {
                    goal.milestones.append(Milestone(name: "win", sig: true, image: Image("fedW"), imageUrl: URL(string: ""), caption: "won"))
                } label: {
                    Text("click")
                }
            }
        }

        
    }
}
