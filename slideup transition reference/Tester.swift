//
//  Tester.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 4/1/23.
//

import SwiftUI


struct Tester: View {
    @State private var username = "Anonymous"
        @State private var bio = ""
        @State private var isLoading = false
        var body: some View {
            ScrollView {
                VStack {
                    ZStack {
                        Circle()
                            .stroke(Color(.systemGray5), lineWidth: 14)
                            .frame(width: 100, height: 100)
                        
                        Circle()
                            .trim(from: 0, to: 0.2)
                            .stroke(Color.green, lineWidth: 7)
                            .frame(width: 100, height: 100)
                            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                            .onAppear() {
                                self.isLoading = true
                            }
                    }
                }
                .padding(.horizontal)
            }
            .scrollDismissesKeyboard(.immediately)
        }
}

struct Tester1: PreviewProvider {
    static var previews: some View {
        Tester()
    }
}

