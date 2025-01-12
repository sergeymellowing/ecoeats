//
//  ContentView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appController = AppController()
    
    @AppStorage("isAppOnboarded") private var isAppOnboarded = Defaults.isAppOnboarded
    
    var body: some View {
        ZStack {
            switch appController.appState {
            case .onboarding:
                Onboarding()
            case .signin:
                SignIn()
            case .main:
                Main()
            case .isAdmin:
                ScannerView()
            case .initial:
                LaunchScreen()
            }
        }
        .environmentObject(appController)
//        .environmentObject(dataController)
        .onAppear {
//            isAppOnboarded = false
            appController.getCurrentAuthSession()
        }
    }
}

#Preview {
    ContentView()
}
