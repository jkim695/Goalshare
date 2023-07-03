//
//  Login.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/25/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
struct Login: View {
    @EnvironmentObject var viewModel: AccountViewModel
    @State var userIsLoggedIn = false
    @State var username = ""
    @State var password = ""
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
            Text("Goalshare")
                .font(Font.custom(
                    "Lexend-SemiBold",
                    fixedSize: 64))
                .foregroundColor(.black)
                .padding()
                .cornerRadius(15)
            TextField("Email Address", text: $username)
                .padding()
            TextField("password", text: $password)
                .padding()
            Button {
                login()
            } label: {
                Text("Login")
                    .font(Font.custom(
                        "Lexend-SemiBold",
                        fixedSize: 20))
                    .foregroundColor(.black)
                    .padding()
                    .background(.yellow)
                    .cornerRadius(15)
            }
            NavigationLink(destination: RegisterView()) {
                Text("New User? Take me to register page")
            }
        }
        .navigationBarBackButtonHidden()
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
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
