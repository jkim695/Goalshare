//
//  Main.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 3/29/23.
//

import Foundation
import SwiftUI
import Firebase

@main
struct Goalshare_tree2App: App {
    init () {
        FirebaseApp.configure()
    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var introducing = true
    var body: some Scene {
        let account = Account()
        account.goals.append(Goal(name: "win", date: Date(), color: Color.red))
        account.goals.append(Goal(name: "win", date: Date(), color: Color.red))
        account.goals.append(Goal(name: "win", date: Date(), color: Color.red))
        return WindowGroup {
            Profile()
                .environmentObject(Account())
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
                    AppDelegate.orientationLock = .portrait // And making sure it stays that way
                }.onDisappear {
                    AppDelegate.orientationLock = .all // Unlocking the rotation when leaving the view
                }
                .fullScreenCover(isPresented: $introducing) {
                    IntroductionVideo()
                        .environmentObject(MyState())
                }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.all //By default you want all your views to rotate freely
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

