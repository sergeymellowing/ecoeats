//
//  AccountView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/20/24.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        //                            ScannerView()
        VStack(spacing: 20) {
            Text("Account View")
            if appController.apiUser == nil {
                
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
                
            } else {
                Button(action: { appController.signOut() }) {
                    Text("Sign out")
                }
                .buttonStyle(.bordered)
            }
            
        }
    }
}

#Preview {
    AccountView()
}
