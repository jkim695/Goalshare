//
//  Profile.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI
import UIKit
import FirebaseAuth
struct Profile: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var account: Account
    @EnvironmentObject var viewModel: AccountViewModel
    @State private var isSlideUpViewPresented = false
    @State private var isAnimating = false
    @State private var editing = false
    @State private var showDropdown = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("My")
                            .font(Font.custom("Lexend-SemiBold", fixedSize: 36))
                            .foregroundColor(.black)
                        Text("Goals.")
                            .font(Font.custom("Lexend-SemiBold", fixedSize: 50))
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 30)
                    Spacer()

                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width:25, height: 25)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .padding(.top, 34)
                        .padding(.trailing, 13)
                        .onTapGesture {
                            withAnimation {
                                self.showDropdown.toggle()
                            }
                        }
                        .overlay(
                            VStack {
                                if showDropdown {
                                    Button(action: {
                                        do {
                                            try Auth.auth().signOut()
                                            viewModel.account = nil
                                            showDropdown = false
                                        } catch {
                                            print("Error signing out")
                                        }
                                    }) {
                                        Text("Logout")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding()
                                            .frame(width: 100, height: 30)
                                            .background(Color.white)
                                            .cornerRadius(15.0)
                                            .shadow(radius: 3)
                                    }
                                    .transition(.move(edge: .top))
                                }
                            }
                            .padding(.top, 130)
                            .padding(.trailing, 10)
                        )

                    Button(action: {
                        isSlideUpViewPresented.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .frame(width:55, height: 55)
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(.yellow)
                                .frame(width:30, height:30)
                        }
                    }
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                }
                .frame(maxWidth: .infinity)
                GoalDisplay()
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(.all, edges: .bottom)
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.998, green: 0.998, blue: 0.99607), Color(red: 0.898, green: 0.8588, blue: 0.79607)]), startPoint: .top, endPoint: .bottom)
                }
                .edgesIgnoringSafeArea(.all)
            )
        }
        .fullScreenCover(isPresented: $isSlideUpViewPresented) {
            AddGoal()
                .environmentObject(account)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
        .fullScreenCover(isPresented: $editing) {
            GoalSelector()
                .environmentObject(account)
        }
    }
}





extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: gestureRecognizer.view)
        if let tappedView = gestureRecognizer.view?.hitTest(location, with: nil), !(tappedView is UITextField) && !(tappedView is UITextView) {
            gestureRecognizer.view?.endEditing(true)
        }
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false // set to `false` if you don't want to detect tap during other gestures
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Profile_previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(Account(id: "", username: "Federer"))
    }
}
