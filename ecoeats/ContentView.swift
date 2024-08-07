//
//  ContentView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appController = AppController()
    @StateObject var dataController = DataController()
    
    var body: some View {
        ZStack {
            switch appController.appState {
            case .onboarding:
                Onboarding()
            case .signin:
                SignIn()
            case .main:
                Main()
            }
        }
        .environmentObject(appController)
        .environmentObject(dataController)
        .onAppear {
            appController.getCurrentAuthSession()
        }
    }
}

#Preview {
    ContentView()
}
