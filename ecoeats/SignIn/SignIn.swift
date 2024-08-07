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
        Text("Sign In")
//            .onTapGesture {
//                appController.appState = .main
//            }
    }
}

#Preview {
    SignIn()
}
