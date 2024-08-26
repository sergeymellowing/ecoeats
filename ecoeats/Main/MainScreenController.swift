//
//  MainScreenController.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import SwiftUI
import MapKit

class MainScreenController: ObservableObject {
    @Published var state: MainState = .list
    @Published var currentLocationOn: Bool = true
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.55, longitude: 126.99), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    func setRegion(lat: Double, lng: Double, delta: Double? = nil) {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: lng),
            span: MKCoordinateSpan(latitudeDelta: delta ?? 0.1, longitudeDelta: delta ?? 0.1))
    }
}
