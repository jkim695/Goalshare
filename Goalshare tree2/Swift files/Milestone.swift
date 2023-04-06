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
    let idCol = Expression<String>("id")
    let goalIdCol = Expression<Int64>("goal_id")
    let nameCol = Expression<String>("name")
    let sigCol = Expression<Bool>("sig")
    let dateCol = Expression<String>("date")
    let captionCol = Expression<String>("caption")
    let imageCol = Expression<Data>("image")
    
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
            self.idCol <- id.uuidString,
            self.goalIdCol <- goalId,
            self.nameCol <- name,
            self.sigCol <- sig,
            self.dateCol <- date,
            self.captionCol <- caption,
            self.imageCol <- (self.image.jpegData(compressionQuality: 1.0) ?? Data())
        )
        
        do {
            let rowid = try db.run(insert)
            print("Inserted milestone with id \(rowid)")
        } catch {
            print("Insertion failed")
        }
    }
}






