//
//  StackNotTests.swift
//  ecoeats
//
//  Created by 이준녕 on 8/26/24.
//

import SwiftUI
import CachedAsyncImage

struct StoresStack : View {
    @Binding var selectedStore: Store?
    
    func offsetForIndex(_ index : Int) -> CGFloat {
        CGFloat((3 - index - 1) * (-16) )
    }
    
    func horizontalPaddingForIndex(_ index : Int) -> CGFloat {
        CGFloat(20 + index * 16)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            GeometryReader { reader in
                ForEach(0..<3) { index in
                        HStack {
                            if index == 0 {
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
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.top, 4)
                                
                                VStack {
                                    Text(selectedStore?.storeName ?? "")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                    Text(selectedStore?.address ?? "")
                                        .font(.system(size: 14))
                                        .foregroundColor(.green100)
                                }
                                Spacer()
                                
                                VStack {
                                    Spacer()
                                    // TODO: DISTANCE
                                    Text("24.3 km")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.green100)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 5)
                                        .background(.green900)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .frame(height: 92)
                        .background(.greenMain)
                        .cornerRadius(12)
                        .padding(.horizontal, horizontalPaddingForIndex(index))
                        .shadow(color: .black.opacity(0.2), radius: 30)
                        .offset(x: 0, y: offsetForIndex(index))
                        .zIndex(Double(-index))
                    
                }
            }
            .frame(height: CGFloat(100 + 12))
        }
        .padding(.bottom, 30)
    }
}
