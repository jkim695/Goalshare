//
//  Account.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/29/23.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class Account: ObservableObject {
    @Published var goals: [Goal] {
        didSet {
            for goal in goals {
                // Listen for changes in each Goal
                goal.objectWillChange.sink { [weak self] _ in
                    self?.objectWillChange.send()
                }.store(in: &cancellables)
            }
        }
    }
    @Published var id: String
    @Published var username: String
    @Published var likedPhotos: LikedPhotosArray
    private var cancellables: Set<AnyCancellable> = []

    init(id: String, goals: [Goal] = [], username: String) {
        self.id = id
        self.goals = goals
        self.username = username
        self.likedPhotos = LikedPhotosArray(arr: [])
        likedPhotos.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
        for goal in goals {
            // Listen for changes in each Goal
            goal.objectWillChange.sink { [weak self] _ in
                self?.objectWillChange.send()
            }.store(in: &cancellables)
        }
    }

    // Firestore-based initializer
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else {
            return nil
        }

        self.id = document.documentID
        // Since goals are fetched separately, initialize with an empty array
        self.goals = []
        self.username = data["username"]! as? String ?? ""
        self.likedPhotos = LikedPhotosArray(arr: [])
        likedPhotos.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
        for goal in goals {
            // Listen for changes in each Goal
            goal.objectWillChange.sink { [weak self] _ in
                self?.objectWillChange.send()
            }.store(in: &cancellables)
        }
    }
}

