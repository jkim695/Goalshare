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
    @Published var sig: Bool
    @Published var id: UUID
    @Published var name: String
    @Published var image: Image
    @Published var date: String
    @Published var caption: String
    init(name: String, sig: Bool, image: Image, date: String, caption: String) {
        self.id = UUID()
        self.name = name
        self.sig = sig
        self.image = image
        self.date = date
        self.caption = caption
    }
}
