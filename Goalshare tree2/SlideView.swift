//
//  SlideView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/1/23.
//

import SwiftUI

struct SlideView<Content: View>: View {
    let content: Content
    let screenWidth = UIScreen.main.bounds.width

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .frame(width: screenWidth)
    }
}

