//
//  MapAnnotationView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/26/24.
//

import SwiftUI
import CachedAsyncImage

struct MapAnnotationView: View {
    @EnvironmentObject var mainScreenController: MainScreenController
    @Binding var selectedStore: Store?
    let store: Store
    
    var body: some View {
        let selected = self.selectedStore?.id == store.id
        ZStack(alignment: .top) {
            Image(selected ? "selected-pin" : "pin")
                .resizable()
                .scaledToFit()
                .frame(width: selected ? 50 : 40, height: selected ? 70 : 50)
                .opacity(selected ? 1 : 0.7)
            if selected {
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
                .frame(width: 42, height: 42)
                .clipShape(Circle())
                .padding(.top, 4)
                
            } else {
                Text(store.items.count.description)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
            
        }
        .onTapGesture {
            let delta = 0.04
//                    let delta = mainScreenController.region.span.longitudeDelta < 0.1 ? mainScreenController.region.span.latitudeDelta : nil
            withAnimation {
                self.selectedStore = store
                mainScreenController.setRegion(lat: store.location.latitude, lng: store.location.longitude, delta: delta)
                print(self.selectedStore?.storeName)
            }
        }
    }
}

//#Preview {
//    MapAnnotationView()
//}
