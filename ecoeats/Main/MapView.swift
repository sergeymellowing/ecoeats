//
//  MapView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct MapView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var mainScreenController: MainScreenController

//    [
//        StorePin(name: "London", coordinate: CLLocationCoordinate2D(latitude: 37.507222, longitude: 126.99)),
//        StorePin(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 37.2567, longitude: 126.79)),
//        StorePin(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 37.0, longitude: 127.0)),
//        ]
    
    var body: some View {
        let annotations = dataController.stores
        
        Map(coordinateRegion: $mainScreenController.region, annotationItems: annotations) { store in
            //            MapPin(coordinate: $0.coordinate)
            //            Marker("$0.name", coordinate: $0.coordinate)
            //            MapMarker(coordinate: $0.coordinate)
            
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(store.location.latitude), longitude: CLLocationDegrees(store.location.longitude))) {
                NavigationLink(destination: {
                    StoreDetails(store: store)
                }) {
                    Circle()
                        .strokeBorder(.red, lineWidth: 2)
                        .frame(width: 20, height: 20)
                }
            }
        }
    }
}

#Preview {
    MapView()
}
