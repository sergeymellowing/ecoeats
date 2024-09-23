//
//  FollowingView.swift
//  ecoeats
//
//  Created by Sergey Li on 9/23/24.
//

import SwiftUI

struct FollowingView: View {
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        VStack(spacing: 0) {
            SideMenuItemNavi(title: "팔로우하는 가게")
                .padding(.vertical, 20)
                .padding(.bottom, 14)
            
            HStack {
                Text("전체")
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .semibold))
                Text("2")
                    .foregroundColor(.green500)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("최신순")
                    .foregroundColor(.gray800)
                    .font(.system(size: 16))
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray800)
                    .font(.system(size: 16))
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 10)
            
            Divider()
            
            let followingStores: [String] = [
                "123",
                "123"
            ]
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    ForEach(followingStores, id: \.self) { item in
                        FollowingRow()
                    }
                }
                
                .padding(.top, 30)
            }
            .padding(.horizontal, 10)
        }
        .padding(.horizontal, 20)
        .background(Color.gray100)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    FollowingView()
}
