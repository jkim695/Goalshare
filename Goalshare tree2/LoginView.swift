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
struct LoginView: View {
    @State var username = ""
    @State var password = ""
    @State var userIsLoggedIn = false
    @State var emailAlreadyInUse = false // <-- Here
    @State var userID = ""
    var body: some View {
        if userIsLoggedIn {
            Profile()
                .environmentObject(Account(id: userID))
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
        }
//        .onAppear {
//            Auth.auth().addStateDidChangeListener { auth, user in
//                if user != nil {
//                    userIsLoggedIn.toggle()
//                }
//            }
//        }
    }

    func login() {
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "unknown error")
            }
        }
    }

    func register() {
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print(error?.localizedDescription ?? "unknown error")
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
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
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
        var account = Account(document: accountSnapshot) // Assuming you have an Account initializer
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
            var goal = Goal(data: goalDocument.data()) // Assuming you have a Goal initializer
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
    db.collection("accounts").document(userId).collection("goals").document(goalId).collection("milestones").getDocuments { (snapshot, error) in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let snapshot = snapshot else {
            completion(.failure(FirebaseError.noMilestoneData))
            return
        }

        let milestones = snapshot.documents.compactMap { Milestone(data: $0.data()) } // Assuming you have a Milestone initializer
        completion(.success(milestones))
    }
}

enum FirebaseError: Error {
    case noAccountData
    case noGoalData
    case noMilestoneData
    case unknownError
}

