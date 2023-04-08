//
//  ImageView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 12/22/22.
//

import SwiftUI
import SQLite
class Milestone: Identifiable, Codable, ObservableObject {
    static let milestoneTable = Table("milestones")
    static let idCol = Expression<String>("id")
    static let goalIdCol = Expression<String>("goal_id")
    static let nameCol = Expression<String>("name")
    static let sigCol = Expression<Bool>("sig")
    static let dateCol = Expression<String>("date")
    static let captionCol = Expression<String>("caption")
    static let imageCol = Expression<Data>("image")
    
    @Published var id: UUID
    @Published var name: String
    @Published var sig: Bool
    @Published var date: String
    @Published var caption: String
    @Published var image: UIImage
    
    init(name: String, sig: Bool = false, date: String, caption: String, image: UIImage) {
        self.id = UUID()
        self.name = name
        self.sig = sig
        self.date = date
        self.caption = caption
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sig = try container.decode(Bool.self, forKey: .sig)
        date = try container.decode(String.self, forKey: .date)
        caption = try container.decode(String.self, forKey: .caption)
        
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
        try container.encode(sig, forKey: .sig)
        try container.encode(date, forKey: .date)
        try container.encode(caption, forKey: .caption)
        
        if let imageData = image.jpegData(compressionQuality: 1.0) {
                try container.encode(imageData, forKey: .image)
            } else {
                // Handle image encoding failure
                throw EncodingError.invalidValue(image, EncodingError.Context(codingPath: [CodingKeys.image], debugDescription: "Unable to encode image"))
            }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, sig, date, caption, image
    }
    
    static func createTable() -> String {
        return milestoneTable.create(ifNotExists: true) { t in
            t.column(Expression<String>("id"), primaryKey: true)
            t.column(Expression<Int64>("goal_id"))
            t.column(Expression<String>("name"))
            t.column(Expression<Bool>("sig"))
            t.column(Expression<String>("date"))
            t.column(Expression<String>("caption"))
            t.column(Expression<Data>("image"))
        }
    }
    
    func save(goalId: Int64) {
        guard let db = DatabaseManager.shared.db else { return }
        
        let insert = Milestone.milestoneTable.insert(
            Milestone.idCol <- id.uuidString,
            Milestone.goalIdCol <- goalId,
            Milestone.nameCol <- name,
            Milestone.sigCol <- sig,
            Milestone.dateCol <- date,
            Milestone.captionCol <- caption,
            Milestone.imageCol <- (self.image.jpegData(compressionQuality: 1.0) ?? Data())
        )
        
        do {
            let rowid = try db.run(insert)
            print("Inserted milestone with id \(rowid)")
        } catch {
            print("Insertion failed")
        }
    }
    static func fetchMilestones(forGoalId goalId: UUID) -> [Milestone] {
        guard let db = DatabaseManager.shared.db else { return [] }
        
        var milestones = [Milestone]()
        do {
            for milestoneRow in try db.prepare(Milestone.milestoneTable.filter(Milestone.goalIdCol == goalId.uuidString)) {
                let id = UUID(uuidString: milestoneRow[Milestone.idCol])!
                let name = milestoneRow[Milestone.nameCol]
                let sig = milestoneRow[Milestone.sigCol]
                let date = milestoneRow[Milestone.dateCol]
                let caption = milestoneRow[Milestone.captionCol]
                if let image = UIImage(data: milestoneRow[Milestone.imageCol]) {
                    milestones.append(Milestone(name: name, sig: sig, date: date, caption: caption, image: image))
                }
            }
        } catch {
            print("Failed to fetch milestones")
        }
        return milestones
    }

}






