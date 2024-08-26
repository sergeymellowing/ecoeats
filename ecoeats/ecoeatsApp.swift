//
//  ecoeatsApp.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin

@main
struct ecoeatsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        configureAmplify()
        setupUI()
        return true
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.configure()
        } catch {
            fatalError("An error occurred setting up session.")
        }
    }
    
    private func setupUI() {
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .green800
        UISegmentedControl.appearance().backgroundColor = .darkGray.withAlphaComponent(0.7)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
        UISegmentedControl.appearance().setContentHuggingPriority(.defaultLow, for: .vertical)
        
    }
}
