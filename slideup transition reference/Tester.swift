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

        var body: some View {
            ScrollView {
                VStack {
                    TextField("Name", text: $username)
                        .textFieldStyle(.roundedBorder)
                    TextEditor(text: $bio)
                        .frame(height: 400)
                        .border(.quaternary, width: 1)
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

