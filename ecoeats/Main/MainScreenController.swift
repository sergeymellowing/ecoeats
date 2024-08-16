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
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.55, longitude: 126.99), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    func setRegion(lat: Double, lng: Double) {
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lng), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
    }
}
