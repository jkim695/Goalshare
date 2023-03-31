import SwiftUI

struct MilestoneChain: View {
    @EnvironmentObject var goal: Goal

    var body: some View {
        ScrollView () {
            ForEach(goal.milestones) { milestone in
                NavigationLink {
                    PostView()
                        .environmentObject(milestone)
                } label: {
                    if (!milestone.sig) {
                        MilestoneImageView()
                            .environmentObject(milestone)
                    }
                    else {
                        SigMilestoneImageView()
                            .environmentObject(milestone)
                    }
                }
                LineView()
            }
        }
    }
}

struct MilestoneChain_Previews: PreviewProvider {
    static var previews: some View {
        // add to array to test previews to lazy todo now
        MilestoneChain()
            .environmentObject(Goal(name: "", date: Date(), image: Image("fedW")))
    }
}
