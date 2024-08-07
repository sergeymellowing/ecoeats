//
//  AppController.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import Foundation
import Amplify
import SwiftUI

class AppController: ObservableObject {
    @Published var appState: AppState = .onboarding
    @Published var isLoading: Bool = false
    @AppStorage("isAppOnboarded") private var isAppOnboarded = Defaults.isAppOnboarded
    
    func getCurrentAuthSession() {
        isLoading = true
        if isAppOnboarded {
            Task {
                do {
                    let session = try await Amplify.Auth.fetchAuthSession()
                    if session.isSignedIn {
                        self.appState = .main
                    } else {
                        print("User not logged in")
                        self.appState = .signin
                    }
                } catch let error as AuthError {
                    isLoading = false
                    print("Sign in failed \(error)")
                } catch {
                    isLoading = false
                    print("Unexpected error: \(error)")
                }
            }
        } else {
            self.appState = .onboarding
        }
    }
}
