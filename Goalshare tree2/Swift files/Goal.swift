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
    @Published var id: String?
    @Published var milestones: [Milestone]
    @Published var pin: Bool

    init(id: String, name: String, date: Date, pin: Bool) {
        self.id = id
        self.name = name
        self.date = date
        self.milestones = []
        self.pin = pin
    }
    init?(data: [String: Any]) {
        if let name = data["name"] as? String {
            self.name = name
        } else {
            print("Failed to initialize Goal because name is missing or not a String")
            return nil
        }

        if let timestamp = data["date"] as? Timestamp {
            self.date = timestamp.dateValue()
        } else {
            print("Failed to initialize Goal because date is missing or not a Timestamp")
            return nil
        }

        if let pin = data["pin"] as? Bool {
            self.pin = pin
        } else {
            print("Failed to initialize Goal because pin is missing or not a Bool")
            return nil
        }

        if let id = data["id"] as? String {
            self.id = id
        } else {
            print("Failed to initialize Goal because id is missing or not a String")
            return nil
        }

        self.milestones = [] // You'll populate this asynchronously with loadMilestones
    }


}

