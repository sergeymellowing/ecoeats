//
//  SignIn.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct SignIn: View {
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            // MARK: FOR TESTS PURPOSES
                            appController.signIn(email: "sevastiyan.tsv@gmail.com", password: "myPassword1")
                        }
                    Text("ECO EATS")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.white)
                }.padding(.top, 50)
                
                Text("가까운 이득, 쉬운 실천의 시작!")
                    .foregroundColor(.green200)
                    .font(.system(size: 16))
                
                Spacer()
                Spacer()
                
                Text("어렵지 않아요\n바로 쉽게 시작하세요")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .semibold))
                    .lineSpacing(7)
                
                HStack(alignment: .center, spacing: 20) {
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
                    Spacer()
                }
                
                Text("SNS 로그인을 통해 본 서비스에 가입함으로써, 귀하는 당사의 이용약관에 동의하게됩니다. 당사의 개인정보 사용방식에 관한 내용은 개인정보 취급방침에서 확인하실 수 있습니다.")
                    .foregroundColor(.white.opacity(0.6))
                    .font(.system(size: 14, weight: .light))
                    .lineSpacing(6)
                
                NavigationLink(destination: {
                    EmailSignIn()
                }) {
                    Text("이메일 로그인")
                        .foregroundColor(.yellow200)
                        .font(.system(size: 16, weight: .light))
                        .underline()
                }
                .padding(.vertical)
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    Text("가입을 망설이시나요?\n이용 전 둘러보기도 가능해요")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .lineSpacing(6)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            appController.appState = .main
                        }
                    }) {
                        Text("둘러보고 가입하기")
                            .foregroundColor(.yellow200)
                            .font(.system(size: 16, weight: .light))
                            .underline()
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 20)
            .background(.greenMain)
        }
    }
}

#Preview {
    SignIn()
}
