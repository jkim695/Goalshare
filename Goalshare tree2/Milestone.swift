//
//  ImageView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 12/22/22.
//

import SwiftUI

struct Milestone: View {
    let image: Image

    var body: some View {
        image
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
    }
}

struct Milestone_Preview: PreviewProvider {
    static var previews: some View {
        Milestone(image: Image("fedW"))
    }
}
