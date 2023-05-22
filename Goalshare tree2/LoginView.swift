//
//  LoginView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/13/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct LoginView: View {
    @State var username = ""
    @State var password = ""
    @State var userIsLoggedIn = false
    var body: some View {
        if userIsLoggedIn {
            Profile()
                .environmentObject(Account(username: "", password: ""))
        }
        else {
            content
        }
    }
    var content: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
            TextField("password", text: $password)
                .padding()
            Button {
                register()
            } label: {
                Text("click")
            }

        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userIsLoggedIn.toggle()
                }
            }
        }
    }
    func login() {
        Auth.auth().signIn(withEmail: username, password: password) {
            result, error in
            if error != nil {
                print("error.localized_description")
            }
        }
    }
    func register() {
        Auth.auth().createUser(withEmail: username, password: password) { result, error in
            if  error != nil {
                print("error.localized_description")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
