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
        let viewModel = AccountViewModel()
        viewModel.account = nil
        return WindowGroup {
            OpeningScreen()
                .environmentObject(viewModel)

        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.all //By default you want all your views to rotate freely
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

