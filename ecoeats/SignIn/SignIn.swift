//
//  SignIn.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct SignIn: View {
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        Button(action: {
            appController.signIn(email: "sevastiyan.tsv@gmail.com", password: "myPassword1")
        }) {
            Text("Sign In")
        }
        .buttonStyle(.bordered)
//            .onTapGesture {
//                appController.appState = .main
//            }
    }
}

#Preview {
    SignIn()
}
