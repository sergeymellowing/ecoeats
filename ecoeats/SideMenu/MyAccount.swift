//
//  MyAccount.swift
//  ecoeats
//
//  Created by Sergey Li on 9/20/24.
//

import SwiftUI

struct MyAccount: View {
    @EnvironmentObject var appController: AppController
    
    @State var notif1: Bool = true
    @State var notif2: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            SideMenuItemNavi(title: "내 계정")
                .padding(20)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Image("ic-\(Defaults.signInProvider)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .padding(.bottom, 20)
                        .padding(.top, 40)
                    
                    Text(appController.apiUser?.email ?? "")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    
                    Text("\(providerName) 계정을 이용하여 로그인 하셨습니다.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray800)
                        .padding(.bottom, 40)
                    
                    Divider()
                        .padding(.bottom, 30)
                    
                    HStack {
                        Text("환경보호 실천")
                            .foregroundColor(.black)
                        Spacer()
                        Text("4 회")
                            .foregroundColor(.green500)
                    }
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 30)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Text("지금까지 받은 혜택")
                            .foregroundColor(.black)
                        Spacer()
                        Text("110,500 원")
                            .foregroundColor(.green500)
                    }
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 30)
                    .padding(.horizontal, 10)
                    
                    Divider()
                        .padding(.bottom, 30)
                    
                    HStack {
                        Text("알림설정")
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.bottom, 20)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Text("이벤트 할인 혜택 정보")
                            .foregroundColor(.gray600)
                        Spacer()
                        Toggle(isOn: $notif1) {}.tint(.gray600)
                    }
                    .font(.system(size: 16))
                    .padding(.bottom, 20)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Text("팔로우하는 가게 상품 재입고")
                            .foregroundColor(.gray600)
                            .layoutPriority(1)
                        Spacer()
                        Toggle(isOn: $notif2) {}.tint(.gray600)
                    }
                    .font(.system(size: 16))
                    .padding(.bottom, 30)
                    .padding(.horizontal, 10)
                    
                    Divider()
                        .padding(.bottom, 30)
                    
                    HStack {
                        Button(action: {
                            appController.signOut()
                        }) {
                            Text("로그아웃")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.bottom, 30)
                    .padding(.horizontal, 10)
                    
                    Divider()
                        .padding(.bottom, 30)
                    
                    HStack {
                        Button(action: {
                            appController.signOut()
                        }) {
                            Text("회원탈퇴")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.bottom, 30)
                    .padding(.horizontal, 10)
                    
                    Divider()
                        .padding(.bottom, 30)
                    
                    Spacer(minLength: 200)
                }
                .padding(.horizontal, 20)
            }
        }
        .background(Color.gray100)
        .navigationBarBackButtonHidden()
    }
    
    var providerName: String {
        switch Defaults.signInProvider {
        case "apple":
            "Apple"
        default:
            "Gmail"
        }
    }
}

#Preview {
    MyAccount()
}
