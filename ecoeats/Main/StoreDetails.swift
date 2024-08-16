//
//  StoreDetails.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import SwiftUI
import CachedAsyncImage

struct StoreDetails: View {
    @EnvironmentObject var mainScreenController: MainScreenController
    @EnvironmentObject var locationManager: LocationManager
    @State var selectedItem: Item? = nil
    
    let store: Store
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                CachedAsyncImage(
                    url: "https://picsum.photos/200/300",
                    placeholder: { progress in
                        // Create any view for placeholder (optional).
                        ZStack {
                            ProgressView() {
                                VStack {
                                    Text("\(progress) %")
                                }
                            }
                        }
                    },
                    image: {
                        // Customize image.
                        Image(uiImage: $0)
                            .resizable()
                            .scaledToFill()
                    }
                    )
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(15)
                
                HStack {
                    Text(store.storeName)
                        .font(.headline)
                    
                    ShareLink(item: URL(string: "https://www.google.com")!) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    Spacer()
                    if let lat = locationManager.lastLocation?.coordinate.latitude, let lng = locationManager.lastLocation?.coordinate.longitude {
                        Text(getDistance(lat: lat, lng: lng, busLat: store.location.latitude, busLng: store.location.longitude))
                    }
                    
                }
                .padding(.bottom)
                
                Text(store.description)
                    .padding(.bottom)
                
                Button(action: {
                    DispatchQueue.main.async {
                        mainScreenController.state = .map
                        mainScreenController.setRegion(lat: store.location.latitude, lng: store.location.longitude)
                    }
                }) {
                    Text("Find on the map")
                }
                .padding(.bottom)
                
                Text("item list")
                
                ForEach(store.items) { item in
                    ItemRow(item: item)
                        .onTapGesture {
                            self.selectedItem = item
                        }
                    Divider()
                }
                .sheet(item: $selectedItem) { item in
                    ItemDetails(item: item)
                }
                Spacer(minLength: 200)
            }
            .padding(.horizontal, 20)
        }
    }
}
