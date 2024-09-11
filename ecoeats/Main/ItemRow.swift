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
        HStack(alignment: .center) {
            CachedAsyncImage(
                url: "https://sallysbakingaddiction.com/wp-content/uploads/2013/05/classic-chocolate-chip-cookies.jpg",
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
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                    Text(item.itemName)
                        .font(.system(size: 18, weight: .bold))
                        .lineLimit(1)
                        .foregroundColor(.black)
                        .padding(.bottom, 3)
                
                    Text(item.description)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .padding(.bottom, 3)
                    
                    HStack {
                        Spacer()
                        ItemElement(image: "ic-discount-arrow", text: item.discount.description + " %")
                        ItemElement(image: "ic-quantity", text: item.quantity.description + "개")
                    }
                }
                .padding(.horizontal, 16)
        }
        .padding(.bottom, 15)
    }
}

//#Preview {
//    ItemRow()
//}
