//
//  StoreRow.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import SwiftUI
import CachedAsyncImage

struct StoreRow: View {
    let store: Store
    
    var body: some View {
        HStack(alignment: .top) {
//                    AsyncImage(url: URL(string: store.imageUrl)) { result in
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
            
//                    CachedAsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/ethnogram-1cd0f.appspot.com/o/Other%2Fparis_baguette.jpeg?alt=media&token=cce5a9d9-e46c-42a5-ae21-8fe41ca8fe8f")) { result in
//                        result.image?
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                    }
                
            VStack(alignment: .leading) {
                Text(store.storeName)
                    .font(.headline)
                Text(store.address)
                    .font(.body)
                Text(store.description)
                    .font(.caption)
            }
        }
    }
}

//#Preview {
//    StoreRow()
//}
