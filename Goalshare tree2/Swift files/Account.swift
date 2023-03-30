//
//  Account.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/29/23.
//

import Foundation
class Account: ObservableObject {
    @Published var username: String
    @Published var password: String
    @Published var goals: [Goal]
    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.goals = []
    }
}
