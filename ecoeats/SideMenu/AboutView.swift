//
//  AboutView.swift
//  ecoeats
//
//  Created by Sergey Li on 9/23/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 0) {
            SideMenuItemNavi(title: "ECO EATS 소개")
                .padding(20)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("개인정보의 처리 목적, 보유 및 이용기간")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    
                    Text(
"""
개인정보보호위원회(이하 `개인정보위'라 한다)는 정보주체의 자유와 권리 보호를 위해 「개인정보 보호법」 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 「개인정보 보호법」 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 ‧ 공개합니다.
"""
)
                        .foregroundColor(.gray600)
                        .font(.system(size: 16))
                        .lineSpacing(6)
                        .padding(.bottom, 30)
                    
                    Spacer(minLength: 200)
                }
                .padding(.horizontal, 30)
            }
        }
        .background(Color.gray100)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AboutView()
}
