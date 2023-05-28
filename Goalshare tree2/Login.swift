//
//  Login.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/25/23.
//

import SwiftUI
import FirebaseAuth
struct Login: View {
    @State var username = ""
    @State var password = ""
    var body: some View {
        VStack {
            TextField("Email Address", text: $username)
                .padding()
            TextField("password", text: $password)
                .padding()
            Button {
                Auth.auth().signIn(withEmail: username, password: password) { result, error in
                    if error != nil {
                        print(error?.localizedDescription ?? "unknown error")
                    }
                }
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

        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
