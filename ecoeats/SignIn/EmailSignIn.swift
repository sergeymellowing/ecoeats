//
//  EmailSignIn.swift
//  Eco Eat
//
//  Created by Sergey Li on 10/23/24.
//

import SwiftUI

struct EmailSignIn: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appController: AppController
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
                HStack {
                    BlurButton(icon: "ic-chevron.back", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    Spacer()
                    
                    Text("이메일 로그인")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    BlurButton(icon: "ic-chevron.back", action: {
                        
                    }).opacity(0.0001)
                }
                .padding(20)
            
            Divider()
            
            VStack {
                
                TextField("", text: $email)
                    .placeholder(when: email.isEmpty) {
                        Text("이메일").foregroundColor(.gray)
                    }
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.green100, lineWidth: 1)
                    )
                    .padding(.bottom)
                    .padding(.top, 50)
                
                SecureField("", text: $password)
                    .placeholder(when: password.isEmpty) {
                        Text("비밀번호").foregroundColor(.gray)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.green100, lineWidth: 1)
                    )
                
                Spacer()
                
                Button(action: {
                    // email: "sevastiyan.tsv@gmail.com", password: "myPassword1"
                    appController.signIn(email: email, password: password)
                }) {
                    Group {
                        if appController.isLoading {
                            ProgressView().tint(.black)
                        } else {
                            Text("로그인")
                        }
                    }
                    .font(.system(size: 18))
                    .foregroundColor(.green100)
                    .frame(width: 140, height: 58)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.green100, lineWidth: 1)
                    )
                    .cornerRadius(14)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 15)
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, 20)
        }
        .background(.greenMain)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EmailSignIn()
}
