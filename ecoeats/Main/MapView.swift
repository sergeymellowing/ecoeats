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
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.55, longitude: 126.99), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    let annotations = [
        StorePin(name: "London", coordinate: CLLocationCoordinate2D(latitude: 37.507222, longitude: 126.99)),
        StorePin(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 37.2567, longitude: 126.79)),
        StorePin(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 37.0, longitude: 127.0)),
        ]
    
    var body: some View {
//        Map()
        Map(coordinateRegion: $region, annotationItems: annotations) {
//            MapPin(coordinate: $0.coordinate)
            
//            MapMarker(coordinate: $0.coordinate)
            MapAnnotation(coordinate: $0.coordinate) {
                Circle()
                        .strokeBorder(.red, lineWidth: 4)
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            print("BOO")
                        }
            }
//            Marker("$0.name", coordinate: $0.coordinate)
        }
    }
}

#Preview {
    MapView()
}
