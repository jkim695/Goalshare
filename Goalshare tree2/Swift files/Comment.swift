//
//  Comment.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 1/27/24.
//

import Foundation
class Comment: ObservableObject {
    @Published var text: String
    @Published var username: String
    init(text: String, username: String) {
        self.text = text
        self.username = username
    }
}
