//
//  MyAccount.swift
//  ecoeats
//
//  Created by Sergey Li on 9/20/24.
//

import SwiftUI

struct MyAccount: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appController: AppController
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    BlurButton(icon: "ic-chevron.back", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    Spacer()
                    
                    Text("내 계정")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    BlurButton(icon: "ic-chevron.back", action: {
                        
                    }).opacity(0.0001)
                }
                .padding(20)
                
                Divider()
                    .padding(.bottom, 40)
                
                Image("ic-\(Defaults.signInProvider)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.bottom, 20)
                
                Text(appController.apiUser?.email ?? "")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.bottom, 10)
                
                Text("\(providerName) 계정을 이용하여 로그인 하셨습니다.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray800)
                    .padding(.bottom, 40)
                
                Button(action: { appController.signOut() }) {
                    Text("Sign out")
                }
                .buttonStyle(.bordered)
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
