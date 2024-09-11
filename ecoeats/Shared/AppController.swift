//
//  AppController.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import Foundation
import Amplify
import SwiftUI
import AWSCognitoAuthPlugin

class AppController: ObservableObject {
    @Published var appState: AppState = .initial
    @Published var isLoading: Bool = false
    @Published var apiUser: ApiUser? = nil
    
    @AppStorage("isAppOnboarded") private var isAppOnboarded = Defaults.isAppOnboarded
//    @AppStorage("lookAround") private var lookAround = Defaults.lookAround
    
    func getCurrentAuthSession() {
        isLoading = true
        if isAppOnboarded {
            Task {
                do {
                    let session = try await Amplify.Auth.fetchAuthSession()
                    if session.isSignedIn {
                        syncAuthAndApiUser { success in
//                            self.lookAround = false
                            self.appState = self.apiUser?.isAdmin ?? false ? .isAdmin : .main
                            self.isLoading = false
                        }
                    } else {
                        print("User not logged in")
                        await MainActor.run {
                            if self.apiUser != nil {
                                self.appState = .main
                                isLoading = false
                            } else {
                                self.appState = .signin
                                isLoading = false
                            }
                            
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
    
    @MainActor
    func signOut() {
        Task {
            self.isLoading = true
            _ = await Amplify.Auth.signOut()
            print("Sign out succeeded")
            self.apiUser = nil
            self.appState = .signin
        }
    }
    
    func signInWithWebUI(provider: AuthProvider) {
        var window: UIWindow {
            guard
                let scene = UIApplication.shared.connectedScenes.first,
                let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                let window = windowSceneDelegate.window as? UIWindow
            else {
                return UIWindow()
            }
            return window
        }
        
        let options = AuthWebUISignInRequest.Options(
            scopes: ["email", "openid", "aws.cognito.signin.user.admin"],
            pluginOptions: AWSAuthWebUISignInOptions(preferPrivateSession: true)
        )
        self.isLoading = true
        // MARK: @MainActor needs to use computing variable window
        Task.detached { @MainActor in
            do {
                let signInWithWebUIResult = try await Amplify.Auth.signInWithWebUI(for: provider, presentationAnchor: window, options: options)
                
                switch signInWithWebUIResult.nextStep {
                case .done:
//                    let username = try await Amplify.Auth.getCurrentUser().username
                    
                    switch provider {
                    case .apple:
                        Defaults.signInProvider = "apple"
                    case .facebook:
                        Defaults.signInProvider = "facebook"
                    case .google:
                        Defaults.signInProvider = "google"
                    default:
                        Defaults.signInProvider = "other"
                    }
                    
//                    self.userService.syncAuthAndApiUser(username: username) { success in
//                        print("User sync success \(success)")
//                        Defaults.autoLoginEnabled = true
//                        self.isUserOnboardingCompleted = false
//                    }
                    self.getCurrentAuthSession()
                default: print("undone")
                }
            } catch {
                self.getCurrentAuthSession()
                print("Sign in failed: \(error)")
            }
            self.isLoading = false
        }
    }
    
    func getUser(id: String, completion: @escaping (ApiResult<ApiUser>) -> Void) {
        let queryParameters = ["id": id]
        let request = RESTRequest(apiName: Const.API,
                                  path: "/user/get",
                                  queryParameters: queryParameters)
        
        Task {
            do {
                let data = try await Amplify.API.get(request: request)
                let str = String(decoding: data, as: UTF8.self)
                print("Get user success \(str)")
                if let response: GetApiNodeUserResponse = decodeJson(data: data) {
                    completion(.success(response.data))
                } else {
                    completion(.failure(ApiError.invalidJSON))
                }
            } catch let error as APIError {
                print("Get user failure \(error)")
                switch error {
                case .httpStatusError(let statusCode, _):
                    if statusCode == 404 {
                        completion(.failure(ApiError.notFound))
                        return
                    }
                default:
                    print("No response from server")
                }
                completion(.failure(ApiError.httpError))
            }
        }
    }
    
    
    func createUser(user: ApiUser, completion: @escaping (Bool) -> Void) {
        let getUserRequest = CreateApiNodeUserRequest(item: user)
        
        if let requestBody = encodeJson(data: getUserRequest) {
            let request = RESTRequest(apiName: Const.API,
                                      path: "/user/create",
                                      body: requestBody)
            
            Task {
                do {
                    let data = try await Amplify.API.post(request: request)
                    let str = String(decoding: data, as: UTF8.self)
                    print("Create user success \(str)")
                    completion(true)
                } catch let apiError {
                    print("Create user failed \(apiError)")
                    completion(false)
                }
            }
        }
    }
    
    func updateUser(id: String, user: ApiUser, completion: @escaping (ApiUser?) -> Void) {
        let getUserRequest = UpdateApiNodeUserRequest(id: id, item: user)
        
        if let requestBody = encodeJson(data: getUserRequest) {
            let request = RESTRequest(apiName: Const.API,
                                      path: "/user/update",
                                      body: requestBody)
            
            print("Update Body \(String(decoding: requestBody, as: UTF8.self))")
            
            Task {
                do {
                    let data = try await Amplify.API.post(request: request)
                    let str = String(decoding: data, as: UTF8.self)
                    print("Update user success:: \(str)")
                    if let response: GetApiNodeUserResponse = decodeJson(data: data) {
                        completion(response.data)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("Update user failure \(error)")
                    completion(nil)
                }
            }
        }
    }
    
    func deleteUser(id: String, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let queryParameters = ["id": id]
                let request = RESTRequest(apiName: Const.API,
                                          path: "/user/delete",
                                          queryParameters: queryParameters)
                
                _ = try await Amplify.API.delete(request: request)
                print("Delete user from DB success")
                try await Amplify.Auth.deleteUser()
                print("Cognito User delete successfully.")
                completion(true)
            } catch let error as AuthError {
                print("Delete user failed with error \(error)")
                completion(false)
            } catch {
                print("Unexpected error: \(error)")
                completion(false)
            }
        }
    }
    
    func syncAuthAndApiUser(completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let authUser = try await Amplify.Auth.getCurrentUser()
                let username = authUser.username
                fetchAuthUserAttributes { [weak self] attributes in
                    guard let self = self else {
                        completion(false)
                        return
                    }
                    
                    if attributes.isEmpty {
                        completion(true)
                        return
                    }
                    
                    var user = ApiUser()
                    user.id = username
                    
                    for attribute in attributes {
                        switch attribute.key {
                        case .familyName:
                            user.familyName = attribute.value
                        case .email:
                            user.email = attribute.value
                        case .name:
                            user.name = attribute.value
                        default:
                            break
                        }
                    }
                    
        //            user.osVersion = "iOS \(UIDevice.current.systemVersion), app: v\(Defaults.version) build\(Defaults.build)"
                    
                    self.getUser(id: username) { result in
                        switch result {
                        case .success(let fetchedUser):
                            var user = fetchedUser
                            
                            for attribute in attributes {
                                switch attribute.key {
                                case .familyName:
                                    user.familyName = attribute.value
                                case .email:
                                    user.email = attribute.value
                                case .name:
                                    user.name = attribute.value
                                default:
                                    break
                                }
                            }
                            self.apiUser = fetchedUser
        //                    user.osVersion = "iOS \(UIDevice.current.systemVersion), app: v\(Defaults.version) build\(Defaults.build)"
                            self.updateUser(id: username, user: user) { fetchedUser in
                                self.apiUser = fetchedUser
                                completion(fetchedUser != nil)
                            }
                        case .failure(ApiError.notFound):
                            self.isAppOnboarded = false
                            self.createUser(user: user) { success in
                                self.apiUser = nil
                                completion(success)
                            }
                        case .failure:
                            print("error")
                            completion(false)
                        }
                    }
                }
            }
        }
      
    }
    
//    private func syncApiUser() async {
//        do {
//            let user = try await Amplify.Auth.getCurrentUser()
//            self.fetchAuthUserAttributes { attr in
//                
//            }
//            
//            print(user)
//            self.getUser(id: user.userId) { result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                    if error as? ApiError == ApiError.notFound {
//                        var apiUser = ApiUser()
//                        apiUser.id = user.userId
//                        self.createUser(user: apiUser) { success in
//                            if success {
//                                self.apiUser = apiUser
//                                self.appState = .main
//                                self.isLoading = false
//                            } else {
//                                print("Something went wrong")
//                                self.apiUser = nil
//                                self.appState = .signin
//                                self.isLoading = false
//                            }
//                        }
//                    } else {
////                        await MainActor.run {
//                        self.apiUser = nil
//                            self.appState = .signin
//                            self.isLoading = false
////                        }
//                    }
//                case .success(let user):
//                    print(user)
//                    self.apiUser = user
//                    self.appState = .main
//                    self.isLoading = false
//                }
//            }
//        } catch {
//            self.apiUser = nil
//            print(error)
//        }
//    }
    
    private func fetchAuthUserAttributes(completion: @escaping ([AuthUserAttribute]) -> Void) {
        Task {
            do {
                let attributes = try await Amplify.Auth.fetchUserAttributes()
                print("User attributes count: \(attributes.count)")
                print(attributes)
                return completion(attributes)
            } catch {
                print("Fetching user attributes failed with error \(error)")
                return completion([])
            }
        }
    }
}
