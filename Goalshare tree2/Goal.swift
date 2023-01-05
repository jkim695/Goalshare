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

struct Goal: Identifiable, Hashable {
    var name: String
    var date: String
    var id: Int
    var milestones: [Milestone]
}


