//
//  SignIn.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct SignIn: View {
    @EnvironmentObject var appController: AppController
    @AppStorage("lookAround") private var lookAround = Defaults.lookAround
    
    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                appController.signIn(email: "sevastiyan.tsv@gmail.com", password: "myPassword1")
            }) {
                Text("Sign In")
            }
            .buttonStyle(.bordered)
            
            Button(action: {
                appController.signInWithWebUI(provider: .google)
            }) {
                Text("GOOGLE")
            }
            .buttonStyle(.bordered)
            
            Button(action: {
                appController.signInWithWebUI(provider: .apple)
            }) {
                Text("APPLE")
            }
            
            Button(action: {
                withAnimation {
                    self.lookAround = true
                    appController.appState = .main
                }
            }) {
                Text("Look aroung")
            }
        }
    }
}

#Preview {
    SignIn()
}
