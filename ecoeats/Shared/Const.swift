//
//  Statics.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import Foundation
import CoreLocation

class Const {
    static let domain = "https://9w88ibphh6.execute-api.ap-northeast-2.amazonaws.com/dev/"
    static let API = "storeApi"
}


func getDistance(cor1: Location, cor2: CLLocationCoordinate2D) -> String {
    let distanceInMeters = CLLocation(latitude: cor1.latitude, longitude: cor1.longitude).distance(from: CLLocation(latitude: cor2.latitude, longitude: cor2.longitude))
    
    let distanceInMetersString = String(format: "%.0f", distanceInMeters)
    let distanceInKm = String(format: "%.1f", distanceInMeters / 1000)

    return distanceInMeters > 1000 ? "\(distanceInKm) km" : "\(distanceInMetersString) m"
    
}
