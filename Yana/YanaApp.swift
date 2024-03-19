//
//  YanaApp.swift
//  Yana
//
//  Created by serhat on 24.12.2023.
//

import SwiftUI
import FirebaseCore
import CoreData
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct YanaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appViewModel = AppViewModel()

    var body: some Scene {
        
        
        
        WindowGroup {
            ContentView().environmentObject(appViewModel)
           
        }
    }
}


