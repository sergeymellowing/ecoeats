//
//  ScanQRRequest.swift
//  ecoeats
//
//  Created by 이준녕 on 8/21/24.
//

import Foundation

struct ScanQRRequest: Codable {
    var userId: String
    var storeId: String
    var itemId: String
}
