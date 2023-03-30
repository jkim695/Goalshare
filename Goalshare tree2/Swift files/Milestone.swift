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

class Milestone: ObservableObject, Identifiable {
    var sig: Bool
    var id: UUID
    var name: String
    var image: Image
    var date: String
    var caption: String
    init(name: String, sig: Bool, image: Image, date: String, caption: String) {
        self.id = UUID()
        self.name = name
        self.sig = sig
        self.image = image
        self.date = date
        self.caption = caption
    }
}

