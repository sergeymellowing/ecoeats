//
//  ItemsStack.swift
//  ecoeats
//
//  Created by Sergey Li on 8/27/24.
//

import SwiftUI
import CachedAsyncImage

struct ItemsStack: View {
    let items: [Item]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    ZStack {
                        VStack {
                            Spacer()
                            VStack {
                                Text(item.itemName)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.top, 66)
                                    .padding(.bottom, 5)
                                
                                Text(item.description)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                    .padding(.bottom, 5)
                                
                                HStack {
                                    ItemElement(image: "ic-discount-arrow", text: item.discount.description + " %")
                                    ItemElement(image: "ic-quantity", text: item.quantity.description + "개")
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .frame(width: UIScreen.main.bounds.width - 120, height: 200)
                            .background(Color.white)
                            .cornerRadius(20)
                            //                    .shadow(radius: 15)
                            .padding(.horizontal, 10)
                            .shadow(radius: 15, y: 15)
                        }
                        
                        VStack {
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
                            .frame(width: 84, height: 84)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                            Spacer()
                        }
                    }
                    .padding(.leading, index == 0 ? 50 : 0)
                    .padding(.trailing, index + 1 >= items.count ? 50 : 0)
                    .onTapGesture {
                        print(item.itemName)
                    }
                }
            }
        }
        .frame(height: 250)
        .padding(.bottom, 140)
    }
}

//#Preview {
//    ItemsStack()
//}

struct ItemElement: View {
    let image: String
    let text: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
            Text(text)
        }
        .font(.system(size: 16, weight: .semibold))
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .overlay(
            RoundedRectangle(cornerRadius: 100)
                .stroke(.gray.opacity(0.4), lineWidth: 1)
        )
    }
}
