//
//  MainState.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import Foundation

enum MainState: CaseIterable, Identifiable {
    case map, list
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .map:
            return "map"
        case .list:
            return "list"
        }
    }
    
    var number: Int {
        switch self {
        case .map:
            0
        case .list:
            1
        }
    }
}
