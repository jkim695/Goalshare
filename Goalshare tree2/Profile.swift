//
//  Profile.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI
import UIKit
struct Profile: View {
    @EnvironmentObject var account: Account
    @State private var isSlideUpViewPresented = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Goals.")
                    .font(.largeTitle)
                Button(action: {
                    isSlideUpViewPresented.toggle()
                }) {
                    Text("Add goal")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                GoalDisplay()
                Spacer()
            }// Hide the back button
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .fullScreenCover(isPresented: $isSlideUpViewPresented) {
        AddGoal()
            .environmentObject(account)
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
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
            .environmentObject(Account(username: "Filler", password: "Filler"))
    }
}
