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
    var name: String
    var date: Date
    var id: UUID
    var image: Image
    var milestones: [Milestone]
    init(name: String, date: Date, image: Image) {
        self.id = UUID()
        self.name = name
        self.image = image
        self.date = date
        self.milestones = []
    }

}


