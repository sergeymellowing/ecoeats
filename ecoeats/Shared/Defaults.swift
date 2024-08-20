//
//  Defaults.swift
//  ecoeats
//
//  Created by 이준녕 on 8/7/24.
//

import Foundation

class Defaults {
    static var isAppOnboarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isAppOnboarded")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isAppOnboarded")
        }
    }
    
    static var signInProvider: String {
        get {
            return UserDefaults.standard.string(forKey: "signInProvider") ?? "email"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "signInProvider")
        }
    }
}
