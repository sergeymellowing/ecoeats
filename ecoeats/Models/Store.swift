//
//  Store.swift
//  ecoeats
//
//  Created by 이준녕 on 8/7/24.
//

import Foundation
import MapKit

struct Store: Identifiable, Codable {
    let id: String
    let storeName: String
    let address: String
    let phoneNumber: String
    let isOpen: Bool
    let openTime: String
    let closeTime: String
    let description: String
    let location: Location
    let items: [Item]
}

struct Location: Codable {
    let latitude: Float
    let longitude: Float
}

struct GetStoresResponse: Codable {
    var data: [Store]
}

struct StorePin: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
