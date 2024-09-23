//
//  MapView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI
import MapKit
import CachedAsyncImage

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct MapView: View {
//    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var mainScreenController: MainScreenController
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        let annotations = mainScreenController.stores
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $mainScreenController.region, showsUserLocation: mainScreenController.currentLocationOn, annotationItems: annotations) { store in
                
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(store.location.latitude), longitude: CLLocationDegrees(store.location.longitude))) {
                    
                    MapAnnotationView(store: store)
                }
            }
            .onTapGesture {
                print("MAP tap")
                mainScreenController.deSelectStore()
            }
            
            if mainScreenController.selectedStore != nil && !mainScreenController.sideMenu {
                StoresStack()
//                CardStackView()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if let lat = locationManager.lastLocation?.coordinate.latitude, let lng = locationManager.lastLocation?.coordinate.longitude, mainScreenController.selectedStore == nil {
                withAnimation {
                    mainScreenController.setRegion(lat: lat, lng: lng, delta: 0.1)
                }
            }
        }
//        .onReceive(mainScreenController.$region) { region in
//            print(region.span.longitudeDelta)
//        }
    }
}

#Preview {
    MapView()
}
