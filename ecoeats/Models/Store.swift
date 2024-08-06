//
//  Store.swift
//  ecoeats
//
//  Created by 이준녕 on 8/7/24.
//

import Foundation

struct Store {
    let id: String
    let lat: Float
    let lng: Float
    let name: String
    let description: String
    let phone: Int
    let address: String
    let openHours: String
    let items: [Item]
}
