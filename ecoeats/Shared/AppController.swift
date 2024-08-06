//
//  AppController.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import Foundation

class AppController: ObservableObject {
    @Published var appState: AppState = .main
}
