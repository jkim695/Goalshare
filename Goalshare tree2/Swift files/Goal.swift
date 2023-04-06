//
//  Goal.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 1/4/23.
//



//class Goal: ObservableObject, Identifiable {
//    @Published var name: String
//    @Published var date: Date
//    @Published var id: UUID
//    @Published var image: Image
//    @Published var milestones: [Milestone]
//    init(name: String, date: Date, image: Image) {
//        self.id = UUID()
//        self.name = name
//        self.image = image
//        self.date = date
//        self.milestones = []
//    }
//
//}
import Foundation
import SwiftUI
import Combine
import SQLite

class Goal: Identifiable, Codable, ObservableObject {
    static let goalTable = Table("goals")
    let idCol = Expression<String>("id")
    let accountIdCol = Expression<Int64>("account_id")
    let nameCol = Expression<String>("name")
    let dateCol = Expression<String>("date")

    @Published var id: UUID
    @Published var name: String
    @Published var date: Date
    @Published var image: Image
    @Published var milestones: [Milestone]

    init(name: String, date: Date, image: Image, milestones: [Milestone] = []) {
        self.id = UUID()
        self.name = name
        self.date = date
        self.image = image
        self.milestones = milestones
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date)
        milestones = try container.decode([Milestone].self, forKey: .milestones)
        
        // You may need a custom solution for decoding the Image, as it's not directly Codable.
        // Here, we set a default image as a placeholder.
        self.image = Image(systemName: "photo")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(milestones, forKey: .milestones)
        // You may need a custom solution for encoding the Image, as it's not directly Codable.
    }

    enum CodingKeys: String, CodingKey {
        case id, name, date, milestones
    }

    // ... (Rest of the Goal class implementation)

    static func createTable() -> String {
        return goalTable.create(ifNotExists: true) { t in
            t.column(Expression<String>("id"), primaryKey: true)
            t.column(Expression<Int64>("account_id"))
            t.column(Expression<String>("name"))
            t.column(Expression<String>("date"))
        }
    }

    func save(accountId: Int64) {
        guard let db = DatabaseManager.shared.db else { return }

        let insert = Goal.goalTable.insert(
            self.idCol <- id.uuidString,
            self.accountIdCol <- accountId,
            self.nameCol <- name,
            self.dateCol <- dateFormatter.string(from: date)
        )
        
        do {
            let rowid = try db.run(insert)
            print("Inserted goal with id \(rowid)")
        } catch {
            print("Insertion failed")
        }
    }
}


