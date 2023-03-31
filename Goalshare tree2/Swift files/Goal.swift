//
//  Goal.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 1/4/23.
//

import SwiftUI
import Foundation
import SwiftUI
import CoreLocation

class Goal: ObservableObject, Identifiable {
    @Published var name: String
    @Published var date: Date
    @Published var id: UUID
    @Published var image: Image
    @Published var milestones: [Milestone]
    init(name: String, date: Date, image: Image) {
        self.id = UUID()
        self.name = name
        self.image = image
        self.date = date
        self.milestones = []
    }

}


