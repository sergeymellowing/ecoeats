//
//  Onboarding.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct Onboarding: View {
    @EnvironmentObject var appController: AppController
    var body: some View {
        NavigationView {
            Text("ONBOARDING")
                .navigationBarItems(trailing:
                                        Button(action: {
                    appController.appState = .signin
                }) {
                    Text("skip")
                }
                )
        }
    }
}

#Preview {
    Onboarding()
}

// init

