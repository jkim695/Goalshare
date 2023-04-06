//
//  Tester.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 4/1/23.
//

import SwiftUI


struct Tester: View {
    @State private var isSlideUpViewPresented = false

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    isSlideUpViewPresented.toggle()
                }) {
                    Text("Show Slide Up View")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        .fullScreenCover(isPresented: $isSlideUpViewPresented) {
            SlideUpView()
        }
    }
}

struct Tester1: PreviewProvider {
    static var previews: some View {
        Tester()
    }
}

