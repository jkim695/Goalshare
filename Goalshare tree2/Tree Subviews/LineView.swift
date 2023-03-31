//
//  LineView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/30/23.
//

import SwiftUI

struct LineView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 195, y: -160))
            path.addLine(to: CGPoint(x: 195, y:-182))
        }
        .stroke(Color.black, lineWidth: 15)
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView()
    }
}
