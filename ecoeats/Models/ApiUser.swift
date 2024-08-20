//
//  ApiUser.swift
//  ecoeats
//
//  Created by 이준녕 on 8/20/24.
//

import Foundation

struct ApiUser: Codable, Hashable {
    var id: String?
    var email: String?
    var name: String?
    var familyName: String?
    var isAdmin: Bool?
//    var age: Int?
//    var height: Int?
//    var weight: Int?
//    var marketing: Bool?
//    var gender: String?
//    var created: String?
//    var updated: String?
//    var offset: Int?
//    var membership: String?
//    var fakeLocation: String?
//    var role: Int?
//    var osVersion: String?
}

struct GetApiNodeUserResponse: Codable {
    var data: ApiUser
}

struct GetApiNodeUsersResponse: Codable {
    var data: [ApiUser]
}


struct CreateApiNodeUserRequest: Codable {
    var item: ApiUser
}

struct UpdateApiNodeUserRequest: Codable {
    var id: String
    var item: ApiUser
}
