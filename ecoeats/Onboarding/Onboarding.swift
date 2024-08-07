//
//  Onboarding.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct Onboarding: View {
    @EnvironmentObject var appController: AppController
    @AppStorage("isAppOnboarded") private var isAppOnboarded = Defaults.isAppOnboarded
    
    var body: some View {
        NavigationView {
            Text("ONBOARDING")
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.isAppOnboarded = true
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
