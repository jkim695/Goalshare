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
    @State private var isAnimating = false
    @State private var editing = false
    var body: some View {
        NavigationStack {
                VStack {
                    HStack {
                        Spacer()
                        Text("My Goals")
                            .font(.largeTitle)
                        Spacer()
                        Button(action: {
                            isSlideUpViewPresented.toggle()
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width:25, height:25)
                        }
                        .padding(.trailing, 10)
                    }
                    GoalDisplay()
                        .padding(.top, 20.0)
                }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(.all, edges: .bottom)
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.blue]), startPoint: .top, endPoint: .bottom)
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
            .environmentObject(Account(username: "Filler", password: "Filler"))
    }
}
