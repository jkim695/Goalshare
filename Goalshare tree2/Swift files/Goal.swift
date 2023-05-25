//
//  Goal.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 1/4/23.
//

import SwiftUI
import Foundation
import FirebaseFirestore


class Goal: ObservableObject, Identifiable {
    @Published var name: String
    @Published var date: Date
    @Published var id: UUID
    @Published var milestones: [Milestone]
    @Published var pin: Bool

    init(name: String, date: Date, pin: Bool) {
        self.id = UUID()
        self.name = name
        self.date = date
        self.milestones = []
        self.pin = pin
    }
    init?(data: [String: Any]) {
        guard let name = data["name"] as? String,
              let timestamp = data["date"] as? Timestamp,
              let pin = data["pin"] as? Bool,
              let idString = data["id"] as? String,
              let id = UUID(uuidString: idString) else {
            return nil
        }
        
        self.name = name
        self.date = timestamp.dateValue()
        self.id = id
        self.pin = pin
        self.milestones = [] // You'll populate this asynchronously with loadMilestones
    }

}

