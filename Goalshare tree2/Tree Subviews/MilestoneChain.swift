import SwiftUI

struct MilestoneChain: View {
    @EnvironmentObject var goal: Goal
    
    var body: some View {
        VStack (spacing: 40) {
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
        // add to array to test previews to lazy todo now
        MilestoneChain()
            .environmentObject(Goal(name: "", date: Date(), color: Color.red))
    }
}
