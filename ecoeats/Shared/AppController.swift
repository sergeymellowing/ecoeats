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
                        await MainActor.run {
                            self.appState = .main
                            isLoading = false
                        }
                    } else {
                        print("User not logged in")
                        await MainActor.run {
                            self.appState = .signin
                            isLoading = false
                        }
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
    
    @MainActor
    func signIn(email: String, password: String) {
        if email.isEmpty {
//            setError(error: .emptyEmail)
        }
        
        if password.isEmpty {
//            setError(error: .emptyPassword)
        }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        Task {
            do {
                let signInResult = try await Amplify.Auth.signIn(username: email, password: password)
                print("Sign in succeeded \(signInResult)")
                print("Next step \(signInResult.nextStep)")
//                Defaults.signInProvider = "email"
//                Defaults.userEmailPlaceholder = Defaults.saveIDEnabled ? self.email : ""
                switch signInResult.nextStep {
                case .done:
                    do {
                        let cognitoUser = try await Amplify.Auth.getCurrentUser()
                        // MARK: Cognito For Korean Server
                        //                    let userId = cognitoUser.username
                        let userId = cognitoUser.userId
                        self.getCurrentAuthSession()
//                        self.userService.syncAuthAndApiUser(username: userId) { success in
//                            self.navigation = nil
//                            print("User sync success \(success)")
//                            self.isLoading = false
//                            self.getCurrentAuthSession()
//                        }
                    } catch {
                        print("no user")
                        self.isLoading = false
//                        self.getCurrentAuthSession()
                    }
                case .confirmSignUp(_):
                    print("Confirm Sign Up")
//                    self.resendSignUpCode()
//                    self.navigation = "confirmationFromSignIn"
                default:
                    print("Default")
//                    self.setError(error: .generalError)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                        self.resetError()
//                    }
                }
                self.isLoading = false
                self.getCurrentAuthSession()
            } catch let error as AuthError {
                switch error {
                case .validation(_, let errorDescription, let recoverySuggestion, let error):
                    print("\(String(describing: error?.localizedDescription))\n\(errorDescription)\n\(recoverySuggestion)")
//                    self.setError(error: .emptyEmail)
                case .notAuthorized(let errorDescription, let recoverySuggestion, let error):
                    print("\(String(describing: error?.localizedDescription))\n\(errorDescription)\n\(recoverySuggestion)")
//                    self.setError(error: .wrongCredentials)
                case .invalidState(let errorDescription, let recoverySuggestion, let error):
                    print("\(String(describing: error?.localizedDescription))\n\(errorDescription)\n\(recoverySuggestion)")
                case .sessionExpired(let errorDescription, let recoverySuggestion, let error):
                    print("\(String(describing: error?.localizedDescription))\n\(errorDescription)\n\(recoverySuggestion)")
//                    self.setError(error: .expiredCode)
                default:
                    print("General error")
//                    self.setError(error: .generalError)
                }
                self.isLoading = false
                self.getCurrentAuthSession()
            } catch {
                self.isLoading = false
                self.getCurrentAuthSession()
                print("Unexpected error: \(error)")
            }
        }
    }
    
    
}
