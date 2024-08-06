//
//  MapView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.55, longitude: 126.99), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
//        Map()
        Map(coordinateRegion: $region)
            .ignoresSafeArea(.all)
    }
}

#Preview {
    MapView()
}
