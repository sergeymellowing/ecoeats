//
//  DistanceString.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import Foundation
import CoreLocation

func getDistance(lat: Double, lng: Double, busLat: Double, busLng: Double) -> String {
        let busCoordinate = CLLocation(latitude: busLat, longitude: busLng)
        let myCoordinate = CLLocation(latitude: lat, longitude: lng)
        let distanceInMeters = busCoordinate.distance(from: myCoordinate)
        let distanceInMetersString = String(format: "%.0f", distanceInMeters)
        let distanceInKm = String(format: "%.1f", distanceInMeters / 1000)

        return (distanceInMeters > 1000 ? "\(distanceInKm) km" : "\(distanceInMetersString) m")
}
