//
//  LoginView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/13/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseFirestoreSwift
struct RegisterView: View {
    @State var username = ""
    @State var password = ""
    @State var userIsLoggedIn = false
    @State var emailAlreadyInUse = false // <-- Here
    @EnvironmentObject var viewModel: AccountViewModel
    @State var userID = ""
    var body: some View {
        if let account = viewModel.account {
            Profile()
                .environmentObject(account)
                .environmentObject(viewModel)
        }
        else {
            content
        }
    }

    var content: some View {
        VStack {
            HStack {
                TextField("Email Address", text: $username)
                    .padding()
                if emailAlreadyInUse {
                    Text("*Email in use")
                        .foregroundColor(.red)
                }
            }
            SecureField("Password", text: $password)
                .padding()
            Button {
                register()
            } label: {
                Text("Register")
            }
            Button {
                login()
            } label: {
                Text("Already have account? Take me to login page")
            }
        }
        .onAppear {
            do {
                try Auth.auth().signOut()
                self.userIsLoggedIn = false
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userIsLoggedIn = true
                }
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                self.userIsLoggedIn = false // Here
                return
            }
            
            if let user = result?.user {
                loadAccount(userId: user.uid) { result in
                    switch result {
                    case .success(let account):
                        print("Account loaded successfully")
                        // Do what you want with the loaded account here
                        // e.g., assign it to your view model
                        DispatchQueue.main.async {
                            self.viewModel.account = account
                        }
                    case .failure(let error):
                        print("Error loading account: \(error)")
                        self.userIsLoggedIn = false // And here
                    }
                }
            } else {
                self.userIsLoggedIn = false // And here
            }
        }
    }



    func register() {
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print(error?.localizedDescription ?? "unknown error")
                self.userIsLoggedIn = false // Here
                return
            }
            let db = Firestore.firestore()
            userID = user.uid
            db.collection("accounts").document(user.uid).setData([
                "goals": [],
                "userID": user.uid
            ]) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                    self.userIsLoggedIn = false // And here
                } else {
                    print("Document successfully written!")

                    // Add this after successfully writing document
                    // Login the user after registering
                    self.login()
                }
            }
        }
    }
    



}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
func loadAccount(userId: String, completion: @escaping (Result<Account, Error>) -> Void) {
    let db = Firestore.firestore()
    db.collection("accounts").document(userId).getDocument { accountSnapshot, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let accountSnapshot = accountSnapshot, accountSnapshot.exists,
              let accountData = accountSnapshot.data() else {
            completion(.failure(FirebaseError.noAccountData))
            return
        }
        let account = Account(document: accountSnapshot) // Assuming you have an Account initializer
        loadGoals(userId: userId) { result in
            switch result {
            case .success(let goals):
                account?.goals = goals
                completion(.success(account!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

func loadGoals(userId: String, completion: @escaping (Result<[Goal], Error>) -> Void) {
    let db = Firestore.firestore()
    db.collection("accounts").document(userId).collection("goals").getDocuments { goalSnapshot, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let goalSnapshot = goalSnapshot else {
            completion(.failure(FirebaseError.noGoalData))
            return
        }

        var goals: [Goal] = []
        let dispatchGroup = DispatchGroup()
        for goalDocument in goalSnapshot.documents {
            dispatchGroup.enter()
            var goal = Goal(data: goalDocument.data()) 
            loadMilestones(userId: userId, goalId: goalDocument.documentID) { result in
                switch result {
                case .success(let milestones):
                    goal?.milestones = milestones
                    goals.append(goal!)
                    dispatchGroup.leave()
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(.success(goals))
        }
    }
}
func loadMilestones(userId: String, goalId: String, completion: @escaping (Result<[Milestone], Error>) -> Void) {
    let db = Firestore.firestore()
    db.collection("accounts").document(userId).collection("goals").document(goalId).collection("milestones").order(by: "date").getDocuments { (snapshot, error) in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let snapshot = snapshot else {
            completion(.failure(FirebaseError.noMilestoneData))
            return
        }

        var milestones: [Milestone] = []
        for document in snapshot.documents {
            do {
                if let milestone = try Milestone(data: document.data()) {
                    milestones.append(milestone)
                }
            } catch {
                print("Error decoding milestone: \(error)")
                completion(.failure(error))
                return
            }
        }
        print(milestones)
        completion(.success(milestones))
    }
}



enum FirebaseError: Error {
    case noAccountData
    case noGoalData
    case noMilestoneData
    case unknownError
}
