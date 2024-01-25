//
//  CircleLoadingView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 1/11/24.
//

import SwiftUI

struct CircleLoadingView: View {
    @State var isLoading = false
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .frame(width: 132)
            Circle()
                .trim(from: 0.58, to: 0.92)
                .stroke(Color.black, lineWidth: 6)
                .frame(width: 105, height: 95)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false))
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
                        self.isLoading = true
                    }
                }
            Circle()
                .trim(from: 0.58, to: 0.92)
                .stroke(Color.black, lineWidth: 6)
                .frame(width: 72, height: 72)
                .rotationEffect(Angle(degrees: isLoading ? -360 : 0))
                .animation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false))
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
                        self.isLoading = true
                    }
                }
        }
    }
}

#Preview {
    CircleLoadingView()
}
