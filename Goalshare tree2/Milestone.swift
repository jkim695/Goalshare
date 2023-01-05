//
//  ImageView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 12/22/22.
//

import SwiftUI
import Foundation
import SwiftUI
import CoreLocation

struct Milestone: Identifiable, Hashable {
    var id: Int
    var name: String
    var date: String
    
    var imageName: String
    var image: Image {
        Image(imageName)
    }
}

