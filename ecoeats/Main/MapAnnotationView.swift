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
    
    let store: Store
    
    var body: some View {
        let selected = mainScreenController.selectedStore?.id == store.id
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
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    mainScreenController.selectStore(store: store)
                }
        )
    }
}

//#Preview {
//    MapAnnotationView()
//}
