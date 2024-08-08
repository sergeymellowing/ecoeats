//
//  Item.swift
//  ecoeats
//
//  Created by 이준녕 on 8/7/24.
//

import Foundation

struct Item: Codable {
    let itemId: Int
    let itemName: String
    let description: String
    let quantity: Int
    let imageUrl: String
    let price: Float
    let discount: Int
}
