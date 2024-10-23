//
//  SideMenu.swift
//  ecoeats
//
//  Created by Sergey Li on 9/20/24.
//

import SwiftUI

struct SideMenu: View {
    @EnvironmentObject var mainScreenController: MainScreenController
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Button(action: {
                withAnimation {
                    mainScreenController.sideMenu = false
                }
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 18, height: 18)
                    .padding(13)
                    .background(.black.opacity(0.3), in: RoundedRectangle(cornerRadius: 8))
            }
            .padding(.top, 10)
            
            Group {
                if let user = appController.apiUser {
                    if let email = appController.apiUser?.email {
                        let fullEmailArray = email.components(separatedBy: "@")
                        (Text((fullEmailArray.first ?? "") + "\n") + Text("@" + (fullEmailArray.last ?? "")))
                            .lineSpacing(5)
                            .font(.system(size: 18))
                    } else {
                        Text("no email")
                            .lineSpacing(5)
                            .font(.system(size: 18))
                    }
                } else {
                    Text("로그인 또는 회원가입\n해주세요")
                        .font(.system(size: 22))
                        .lineSpacing(7)
                }
            }
            .multilineTextAlignment(.trailing)
            .foregroundColor(.white)
            .padding(.top, 64)
            
            
            
            Color.white.opacity(0.3)
                .frame(height: 1)
                .padding(.top, 30)
            
            if appController.apiUser != nil {
                VStack(alignment: .trailing, spacing: 40) {
                    NavigationLink(destination: {
                        MyAccount()
                    }) {
                        Text("내 계정")
                    }
                    
                    NavigationLink(destination: {
                        FollowingView()
                    }) {
                        Text("팔로우하는 가게")
                    }
                    
                    NavigationLink(destination: {
                        AboutView()
                    }) {
                        Text("ECO EATS 소개")
                    }
                    
                    NavigationLink(destination: {
                        TermsView()
                    }) {
                        Text("약관")
                    }
                    
                    NavigationLink(destination: {
                        PrivacyPolicyView()
                    }) {
                        Text("개인정보 처리방침")
                    }
                }
                .font(.system(size: 16))
                .foregroundColor(.gray400)
                .padding(.top, 50)
                
            } else {
                HStack(alignment: .center, spacing: 20) {
                    Spacer()
                    Button(action: {
                        appController.signInWithWebUI(provider: .google)
                    }) {
                        Image("ic-google")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 52, height: 52)
                    }
                    
                    Button(action: {
                        appController.signInWithWebUI(provider: .apple)
                    }) {
                        Image("ic-apple")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 52, height: 52)
                    }
                }
                .padding(.top, 50)
                
                Text("SNS 로그인을 통해 본 서비스에 가입함으로써, 귀하는 당사의 이용약관에 동의하게됩니다. 당사의 개인정보 사용방식에 관한 내용은 개인정보 취급방침에서 확인하실 수 있습니다.")
                    .font(.system(size: 14, weight: .light))
                    .lineSpacing(6)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray400)
                    .padding(.top, 50)
                
                NavigationLink(destination: {
                    EmailSignIn()
                }) {
                    Text("이메일 로그인")
                        .foregroundColor(.yellow200)
                        .font(.system(size: 16, weight: .light))
                        .underline()
                }
                .padding(.vertical)
            }
            
            
            
            Spacer()
            
            Text("v.1.0.0")
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.5))
                .padding(.bottom, 15)
            
        }
        .frame(maxHeight: .infinity)
        .padding(.trailing, 20)
        .frame(width: 220)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .background(Color.greenMenu)
    }
}

#Preview {
    SideMenu()
}
