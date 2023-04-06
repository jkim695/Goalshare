//
//  Main.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/29/23.
//

import Foundation
import SwiftUI
import SQLite

@main
struct Goalshare_tree2App: App {
    init() {
        DatabaseManager.shared.createTables()
    }
    var body: some Scene {
        WindowGroup {
            Profile()
                .environmentObject(Account(username: "placeholder", password: "placeholder"))
        }
    }
}
