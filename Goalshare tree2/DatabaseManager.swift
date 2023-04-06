//
//  DatabaseManager.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 4/6/23.
//

import Foundation
import SQLite

class DatabaseManager {
    static let shared = DatabaseManager()
    var db: Connection?

    private init() {
        let fileManager = FileManager.default
        let documentsDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let dbPath = documentsDirectory?.appendingPathComponent("app.sqlite3")
        do {
            db = try Connection(dbPath!.absoluteString)
        } catch {
            print("Cannot create connection to database")
        }
    }

    func createTables() {
        do {
            try db?.run(Account.createTable())
            try db?.run(Goal.createTable())
            try db?.run(Milestone.createTable())
        } catch {
            print("Unable to create tables")
        }
    }
}

