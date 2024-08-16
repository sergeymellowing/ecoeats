//
//  ItemRow.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import SwiftUI
import CachedAsyncImage

struct ItemRow: View {
    let item: Item
    
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
                        .frame(width: 60, height: 60)
                }
                )
            .cornerRadius(60)
            
            VStack(alignment: .leading) {
                Text(item.itemName)
                HStack {
                    (Text(item.discount.description) + Text( "%"))
                        .padding(.horizontal)
                        .padding(.vertical, 2)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(50)
                    (Text(item.quantity.description) + Text(" left"))
                        .padding(.horizontal)
                        .padding(.vertical, 2)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(50)
                }
            }
        }
    }
}

//#Preview {
//    ItemRow()
//}
