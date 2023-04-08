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
    let accountIdCol = Expression<String>("account_id")
    let usernameCol = Expression<String>("username")
    let passwordCol = Expression<String>("password")
    
    var id: UUID
    var accountId: Int64 = 0
    @Published var username: String
    @Published var password: String
    @Published var goals: [Goal]

    init(username: String, password: String) {
        self.id = UUID()
        self.username = username
        self.password = password
        self.goals = []
    }
    init(id: UUID, username: String, password: String) {
            self.id = id
            self.username = username
            self.password = password
            self.goals = Account.fetchGoals(forAccountId: id)
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


    static func createTable() -> String {
        return accountTable.create(ifNotExists: true) { t in
            t.column(Expression<String>("id"), primaryKey: true)
            t.column(Expression<String>("username"), unique: true)
            t.column(Expression<String>("password"))
        }
    }

    func save() {
        guard let db = DatabaseManager.shared.db else { return }
        
        let insert = Account.accountTable.insert(self.idCol <- id.uuidString, self.usernameCol <- username, self.passwordCol <- password)
        do {
            accountId = try db.run(insert)
            print("Inserted row with id \(accountId)")
            
            for goal in goals {
                goal.save(accountId: accountId)
            }
        } catch {
            print("Insertion failed")
        }
    }

    static func fetchGoals(forAccountId accountId: UUID) -> [Goal] {
        guard let db = DatabaseManager.shared.db else { return [] }
        
        var goals = [Goal]()
        do {
            for goalRow in try db.prepare(Goal.goalTable.filter(Goal.accountIdCol == accountId.uuidString)) {
                let id = UUID(uuidString: goalRow[Goal.idCol])!
                let name = goalRow[Goal.nameCol]
                let date = dateFormatter.date(from: goalRow[Goal.dateCol])!
                let milestones = Goal.fetchMilestones(forGoalId: id)
                goals.append(Goal(name: name, date: date, milestones: milestones, image))
            }
        } catch {
            print("Failed to fetch goals")
        }
        return goals
    }

}

