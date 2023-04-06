//
//  Account.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/29/23.
//

//import Foundation
//class Account: ObservableObject {
//    @Published var username: String
//    @Published var password: String
//    @Published var goals: [Goal]
//    init(username: String, password: String) {
//        self.username = username
//        self.password = password
//        self.goals = []
//    }
//}
import Foundation
import Combine
import SQLite

class Account: ObservableObject, Identifiable, Codable {
    static let accountTable = Table("accounts")
    let idCol = Expression<String>("id")
    let usernameCol = Expression<String>("username")
    let passwordCol = Expression<String>("password")

    var id: UUID
    @Published var username: String
    @Published var password: String
    @Published var goals: [Goal]

    init(username: String, password: String) {
        self.id = UUID()
        self.username = username
        self.password = password
        self.goals = []
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        password = try container.decode(String.self, forKey: .password)
        goals = try container.decode([Goal].self, forKey: .goals)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(username, forKey: .username)
        try container.encode(password, forKey: .password)
        try container.encode(goals, forKey: .goals)
    }

    enum CodingKeys: String, CodingKey {
        case id, username, password, goals
    }

    // ... (Rest of the Account class implementation)

    static func createTable() -> String {
        return accountTable.create(ifNotExists: true) { t in
            t.column(Expression<String>("id"), primaryKey: true)
            t.column(Expression<String>("username"), unique: true)
            t.column(Expression<String>("password"))
        }
    }

    func save() {
        guard let db = DatabaseManager.shared.db else { return }

        let insert = Account.accountTable.insert(
            self.idCol <- id.uuidString,
            self.usernameCol <- username,
            self.passwordCol <- password
        )
        
        do {
            let rowid = try db.run(insert)
            print("Inserted account with id \(rowid)")
        } catch {
            print("Insertion failed")
        }
    }
}

