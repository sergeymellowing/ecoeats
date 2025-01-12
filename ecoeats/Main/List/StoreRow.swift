//
//  StoreRow.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import SwiftUI
import CachedAsyncImage
import CoreLocation

struct StoreRow: View {
    @EnvironmentObject var mainScreenController: MainScreenController
    @EnvironmentObject var locationManager: LocationManager
    let store: Store
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
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
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .black, .clear, .clear]), startPoint: .top, endPoint: .bottom))
                
                HStack(alignment: .bottom) {
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
                    .frame(width: 80, height: 80)
                    .cornerRadius(15)
                    
                    Spacer()
                    
                    Text("~8:30 pm")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.green100)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 5)
                        .background(.green900)
                        .cornerRadius(8)
                        .padding(.trailing, 5)
                        .padding(.bottom, 10)
                    if let current = locationManager.lastLocation?.coordinate {
                        Text(getDistance(cor1: store.location, cor2: current))
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.green100)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 5)
                            .background(.green900)
                            .cornerRadius(8)
                            .padding(.bottom, 10)
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.bottom, 20)
            .onTapGesture {
                mainScreenController.selectedStore = store
                mainScreenController.navigateToStoreDetails = true
            }
            .background(
                NavigationLink(isActive: $mainScreenController.navigateToStoreDetails, destination: {
                        StoreDetails(store: store)
                }) {
                    EmptyView()
                }
            )
            
            ForEach(store.items) { item in
                ItemRow(item: item)
                    .onTapGesture {
                        mainScreenController.selectedStore = store
                        mainScreenController.navigateToStoreDetails = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                mainScreenController.selectedItem = item
                            }
                        }
                    }
            }
            .padding(.horizontal, 10)
        }
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

//#Preview {
//    StoreRow()
//}
