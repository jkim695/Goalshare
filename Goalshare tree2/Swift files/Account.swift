//
//  Account.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/29/23.
//

import Foundation
import SwiftUI
import Combine
class Account: ObservableObject {
    @Published var username: String
    @Published var password: String
    @Published var goals: [Goal] {
            didSet {
                for goal in goals {
                    // Listen for changes in each Goal
                    goal.objectWillChange.sink { [weak self] _ in
                        self?.objectWillChange.send()
                    }.store(in: &cancellables)
                }
            }
        }
    private var cancellables: Set<AnyCancellable> = []
    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.goals = []
    }
}
