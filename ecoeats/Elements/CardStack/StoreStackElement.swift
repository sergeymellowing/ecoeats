//
//  StoreStackElement.swift
//  ecoeats
//
//  Created by Sergey Li on 9/5/24.
//

import SwiftUI
import CachedAsyncImage

struct StoreStackElement: View {
    @EnvironmentObject var locationManager: LocationManager
    let store: Store
    
    var body: some View {
        HStack {
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
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
            VStack(alignment: .leading, spacing: 7) {
                Text(store.storeName)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(store.address)
                    .font(.system(size: 14))
                    .foregroundColor(.green100)
                    .lineLimit(1)
            }
            Spacer()
            
            VStack {
                Spacer()
                
                if let current = locationManager.lastLocation?.coordinate {
                    Text(getDistance(cor1: store.location, cor2: current))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.green100)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 5)
                        .background(.green900)
                        .cornerRadius(8)
                }
            }
        }
        
    }
}

//#Preview {
//    StoreStackElement()
//}
