//
//  MainListView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI
import CachedAsyncImage

struct MainListView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        VStack {
            Spacer(minLength: 70)
            List(dataController.stores) { store in
                HStack {
//                    AsyncImage(url: URL(string: store.imageUrl)) { result in
                    CachedAsyncImage(
                        url: "https://firebasestorage.googleapis.com/v0/b/ethnogram-1cd0f.appspot.com/o/Other%2Fparis_baguette.jpeg?alt=media&token=cce5a9d9-e46c-42a5-ae21-8fe41ca8fe8f",
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
                                .scaledToFit()
                        }
                    )
                    .frame(width: 80)
                    
//                    CachedAsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/ethnogram-1cd0f.appspot.com/o/Other%2Fparis_baguette.jpeg?alt=media&token=cce5a9d9-e46c-42a5-ae21-8fe41ca8fe8f")) { result in
//                        result.image?
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                    }
                        
                    VStack(alignment: .leading) {
                        Text(store.storeName)
                            .font(.title)
                        Text(store.address)
                            .font(.body)
                        Text(store.description)
                            .font(.caption)
                    }
                }
            }.refreshable(action: {
                withAnimation {
                    dataController.stores = []
                    dataController.getStores { error in }
                }
            })
            
            Spacer()
        }
    }
}

#Preview {
    MainListView()
}
