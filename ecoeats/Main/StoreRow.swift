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
                    
                    Text("1.3 km")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.green100)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 5)
                        .background(.green900)
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 10)
            }
            .padding(.bottom, 20)
            
            ForEach(store.items) { item in
                HStack(alignment: .center) {
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
            .padding(.horizontal, 10)
        }
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

//#Preview {
//    StoreRow()
//}
