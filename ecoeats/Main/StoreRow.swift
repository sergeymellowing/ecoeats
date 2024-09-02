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
                ItemRow(item: item)
            }
            .padding(.horizontal, 10)
        }
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

//#Preview {
//    StoreRow()
//}
