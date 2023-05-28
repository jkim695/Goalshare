//
//  AccountViewModel.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/27/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
class AccountViewModel: ObservableObject {
    @Published var account: Account?
    var handle: AuthStateDidChangeListenerHandle?

    init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            if let user = user {
                // User is signed in
                loadAccount(userId: user.uid) { result in
                    switch result {
                    case .success(let account):
                        DispatchQueue.main.async {
                            self.account = account
                        }
                    case .failure(let error):
                        print("Error loading account: \(error)")
                    }
                }
            } else {
                // User is signed out
                DispatchQueue.main.async {
                    self.account = nil
                }
            }
        }
    }

    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}


