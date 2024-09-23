//
//  FollowingRow.swift
//  ecoeats
//
//  Created by Sergey Li on 9/23/24.
//

import SwiftUI
import CachedAsyncImage

struct FollowingRow: View {
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
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
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack(alignment: .leading, spacing: 7) {
                Text("크리스피 프레시")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .bold))
                Text("건강한 슈퍼푸드를 마구마구 엄청 많이 다 더해 만드는 프리미엄 샐러드")
                    .foregroundColor(.gray800)
                    .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    FollowingRow()
}
