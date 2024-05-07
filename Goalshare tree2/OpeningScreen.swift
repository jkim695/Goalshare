//
//  OpeningScreen.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 12/20/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct OpeningScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: AccountViewModel
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var userIsLoggedIn = false
    @State var username = ""
    @State var password = ""
    @State var registeringEmailAddress = ""
    @State var registeringUsername = ""
    @State var registeringPassword = ""
    @FocusState var keyboardFocused: Bool
    @State var registering: Bool = false
    @State var loggingIn: Bool = false
    @State var emailAlreadyInUse = false // <-- Here
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    @State var userID = ""
    @State var isLoading: Bool = false
    @State var loginButtonPressed: Bool = false
    var body: some View {
        if (!registering && !loggingIn) {
            if (viewModel.account != nil) {
                return AnyView(Profile()
                    .environmentObject(viewModel.account!)
                    .environmentObject(viewModel))
            }
            return AnyView(content)
        } else if (registering) {
            return AnyView(registerView)
        }
        return AnyView(loginScreen)
    }
    
    var content: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                Image("Image")
                    .resizable()
                    .frame(width: 150, height: 150)
                Spacer()
                Button {
                    loggingIn = true
                } label: {
                    Text("LOG IN")
                        .font(Font.custom(
                            "Lexend-SemiBold",
                            fixedSize: 28))
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: geometry.size.height * 0.10)
                        .background(.red)
                    
                }
                Button {
                    registering = true
                } label: {
                    Text("SIGN UP")
                        .font(Font.custom(
                            "Lexend-SemiBold",
                            fixedSize: 28))
                        .offset(y: geometry.size.height * 0.01)
                        .padding(.top)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: geometry.size.height * 0.05)
                        .background(.cyan)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(.yellow)
        }
    }
    
    var loginScreen: some View {
        loggingInScreen
    }
    
    var loggingInScreen: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        loggingIn = false
                        keyboardFocused = false
                    } label: {
                        Image(systemName: "arrowshape.left.fill")
                            .resizable()
                            .frame(width: 18, height: 15)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    Spacer()
                }
                Text("Goalshare")
                    .font(Font.custom(
                        "Lexend-SemiBold",
                        fixedSize: 64))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding()
                    .cornerRadius(15)
                TextField("Email Address", text: $username)
                    .padding()
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            keyboardFocused = true
                        }
                    }
                
                SecureField("Password", text: $password)
                    .padding()
                Spacer()
            }
            VStack (alignment: .center) {
                Spacer()
                Button {
                    loginButtonPressed = true
                    login()
                } label: {
                    if (loginButtonPressed) {
                        ZStack {
                            Text("         ")
                                .font(Font.custom(
                                    "Lexend-SemiBold",
                                    fixedSize: 20))
                                .foregroundColor(.black)
                                .padding(.horizontal, 85.0)
                                .padding(.vertical, 7.0)
                                .background(.yellow)
                                .cornerRadius(35)
                            Circle()
                                .trim(from: 0, to: 0.2)
                                .stroke(Color.white, lineWidth: 4)
                                .frame(width: 30, height: 30)
                                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                                .animation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false))
                                .onAppear() {
                                    DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
                                        self.isLoading = true
                                    }
                                }
                        }
                        
                    } else {
                        Text("Log in")
                            .font(Font.custom(
                                "Lexend-SemiBold",
                                fixedSize: 20))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.horizontal, 85.0)
                            .padding(.vertical, 7.0)
                            .background(.yellow)
                            .cornerRadius(35)
                    }
                }
                .padding()
                .padding(.bottom, keyboard.currentHeight / 25)
                .edgesIgnoringSafeArea(.bottom)
                //                .animation(.spring(duration: 0.30))
            }
        }
        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        
    }
    
    var registerView: some View {
        VStack {
            HStack {
                Button {
                    registering = false;
                    keyboardFocused = false
                } label: {
                    Image(systemName: "arrowshape.left.fill")
                        .resizable()
                        .frame(width: 18, height: 15)
                        .foregroundColor(.gray)
                        .padding()
                }
                Spacer()
            }
            Text("Goalshare")
                .font(.custom("lexend-semiBold", size: 64))
            HStack {
                TextField("Email Address", text: $registeringEmailAddress)
                    .padding()
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            keyboardFocused = true
                        }
                    }
                if emailAlreadyInUse {
                    Text("*Email in use")
                        .foregroundColor(.red)
                }
            }
            TextField("Username", text: $registeringUsername)
                .padding()
                .focused($keyboardFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        keyboardFocused = true
                    }
                }
            SecureField("Password", text: $registeringPassword)
                .padding()
            VStack (alignment: .center) {
                Spacer()
                Button {
                    loginButtonPressed = true
                    register()
                } label: {
                    if (loginButtonPressed) {
                        ZStack {
                            Text("         ")
                                .font(Font.custom(
                                    "Lexend-SemiBold",
                                    fixedSize: 20))
                                .foregroundColor(.black)
                                .padding(.horizontal, 85.0)
                                .padding(.vertical, 7.0)
                                .background(.yellow)
                                .cornerRadius(35)
                            Circle()
                                .trim(from: 0, to: 0.2)
                                .stroke(Color.white, lineWidth: 4)
                                .frame(width: 30, height: 30)
                                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                                .animation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false))
                                .onAppear() {
                                    DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
                                        self.isLoading = true
                                    }
                                }
                        }
                        
                    } else {
                        Text("Register")
                            .font(Font.custom(
                                "Lexend-SemiBold",
                                fixedSize: 20))
                            .foregroundColor(.black)
                            .padding(.horizontal, 85.0)
                            .padding(.vertical, 7.0)
                            .background(.yellow)
                            .cornerRadius(35)
                    }
                }
                .padding()
                .padding(.bottom, keyboard.currentHeight / 25)
                .edgesIgnoringSafeArea(.bottom)
            }
            //
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
        
        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    func login() {
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            if let error = error {
                errorMessage = "Incorrect email address or password"
                isLoading = false
                showingErrorAlert = true
                loginButtonPressed = false
                self.userIsLoggedIn = false // Here
                return
            }
            
            if let user = result?.user {
                loadAccount(userId: user.uid) { result in
                    switch result {
                    case .success(let account):
                        print("Account loaded successfully")
                        loggingIn = false
                        registering = false
                        username = ""
                        password = ""
                        registeringEmailAddress = ""
                        registeringUsername = ""
                        registeringPassword = ""
                        isLoading = false
                        self.userIsLoggedIn = true
                        // Do what you want with the loaded account here
                        // e.g., assign it to your view model
                        DispatchQueue.main.async {
                            self.viewModel.account = account
                        }
                        loginButtonPressed = false
                    case .failure(let error):
                        print("Error loading account: \(error)")
                        self.userIsLoggedIn = false // And here
                        loginButtonPressed = false
                        isLoading = false
                    }
                }
            } else {
                self.userIsLoggedIn = false // And here
                loginButtonPressed = false

            }
        }
    }
    func register() {
        Auth.auth().createUser(withEmail: registeringEmailAddress, password: registeringPassword) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                if let err = error as NSError?, err.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    self.errorMessage = "The email is already in use. Please use a different email."
                    self.showingErrorAlert = true
                } else {
                    self.errorMessage = error?.localizedDescription ?? "Unknown error"
                    self.showingErrorAlert = true
                }
                return
            }
            let db = Firestore.firestore()
            userID = user.uid
            db.collection("accounts").document(user.uid).setData([
                "goals": [],
                "username": registeringUsername,
                "userID": user.uid,
                "likedPhotos": []
            ]) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                    self.userIsLoggedIn = false // And here
                    isLoading = false
                } else {
                    print("Document successfully written!")
                    username = registeringEmailAddress
                    password = registeringPassword
                    self.login()
                }
            }
        }
    }
}

#Preview {
    OpeningScreen()
        .environmentObject(AccountViewModel())
}
