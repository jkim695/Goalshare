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
    static let idCol = Expression<String>("id")
    static let accountIdCol = Expression<String>("account_id")
    static let nameCol = Expression<String>("name")
    static let dateCol = Expression<String>("date")

    @Published var id: UUID
    @Published var name: String
    @Published var date: Date
    @Published var image: UIImage
    @Published var goalRowId: Int64 = -1
    @Published var milestones: [Milestone]

    init(name: String, date: Date, image: UIImage, milestones: [Milestone] = []) {
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

        let imageData = try container.decode(Data.self, forKey: .image)
        if let uiImage = UIImage(data: imageData) {
            self.image = uiImage
        } else {
            self.image = UIImage(systemName: "photo")! // Placeholder
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(milestones, forKey: .milestones)

        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try container.encode(imageData, forKey: .image)
        } else {
            throw EncodingError.invalidValue(image, EncodingError.Context(codingPath: [CodingKeys.image], debugDescription: "Unable to encode image"))
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, name, date, milestones, image
    }

    static func createTable() -> String {
        return goalTable.create(ifNotExists: true) { t in
            t.column(Expression<String>("id"), primaryKey: true)
            t.column(Expression<String>("account_id"))
            t.column(Expression<String>("name"))
            t.column(Expression<String>("date"))
        }
    }


    func save(accountId: UUID) {
        guard let db = DatabaseManager.shared.db else { return }

        let insert = Goal.goalTable.insert(
            Goal.idCol <- id.uuidString,
            Goal.accountIdCol <- accountId.uuidString,
            Goal.nameCol <- name,
            Goal.dateCol <- dateFormatter.string(from: date)
        )
        
        do {
            let rowid = try db.run(insert)
            print("Inserted goal with id \(rowid)")
        } catch {
            print("Insertion failed")
        }
    }

    

}


