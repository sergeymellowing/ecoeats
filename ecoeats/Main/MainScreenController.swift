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
    @Published var stores: [Store] = []
    @Published var currentLocationOn: Bool = true
    @Published var selectedStore: Store?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.55, longitude: 126.99), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @Published var selectedItem: Item? = nil
    
    func setRegion(lat: Double, lng: Double, delta: Double? = nil) {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: lng),
            span: MKCoordinateSpan(latitudeDelta: delta ?? 0.1, longitudeDelta: delta ?? 0.1))
    }
    
    func selectStore(store: Store) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let delta = 0.04
    //                    let delta = mainScreenController.region.span.longitudeDelta < 0.1 ? mainScreenController.region.span.latitudeDelta : nil
            withAnimation {
                self.selectedStore = store
                self.setRegion(lat: store.location.latitude, lng: store.location.longitude, delta: delta)
                print(self.selectedStore?.storeName)
                if self.stores.first?.id != store.id {
                    self.stores.removeAll(where: { $0.id == store.id })
                    self.stores.insert(store, at: 0)
                }
            }
        }
        
    }
    
    func deSelectStore() {
        if self.selectedStore != nil {
            withAnimation {
                self.selectedStore = nil
            }
        }
    }
    
    
    // TODO: implement me
    func getStores() {}
}
