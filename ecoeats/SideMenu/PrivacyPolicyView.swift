//
//  PrivacyPolicyView.swift
//  ecoeats
//
//  Created by Sergey Li on 9/23/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @EnvironmentObject var appController: AppController
    var body: some View {
        VStack(spacing: 0) {
            SideMenuItemNavi(title: "개인정보 처리방침")
                .padding(20)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text(
"""
개인정보보호위원회(이하 `개인정보위'라 한다)는 정보주체의 자유와 권리 보호를 위해 「개인정보 보호법」 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 「개인정보 보호법」 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 ‧ 공개합니다.
"""
)
                        .foregroundColor(.gray600)
                        .font(.system(size: 16))
                        .lineSpacing(6)
                        .padding(.top, 40)
                        .padding(.bottom, 30)
                    
                    Text("개인정보의 처리 목적, 보유 및 이용기간")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.bottom, 20)
                    
                    Text(
"""
① 개인정보위는 다음의 목적을 위하여 최소한의 개인정보를 수집하여 처리합니다. 처리하고 있는 개인정보는 다음 목적 이외의 용도로는 이용되지 않으며, 이용목적이 변경되는 경우에는 ｢개인정보 보호법｣ 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
② 개인정보위는 다음과 같이 정보주체의 개인정보를 처리합니다. 개인정보 파일별 상세한 내용은 아래의 안내를 통해 확인할 수 있습니다. 개인정보보호 포털(www.privacy.go.kr) → 개인서비스 → 정보주체 권리행사 → 개인정보 열람등 요구 → 개인정보파일 검색 → 기관명에 "개인정보보호위원회" 입력 후 검색
"""
)
                        .foregroundColor(.gray600)
                        .font(.system(size: 16))
                        .lineSpacing(6)
                        .padding(.bottom, 30)
                    
                    Text("개인정보파일의 등록 현황")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.bottom, 20)
                    
                    Text(
"""
① 개인정보위는 개인정보를 개인정보 처리방침에서 명시한 범위 내에서 처리하고 있으며, ｢개인정보 보호법｣ 제32조에 따라 개인정보파일을 운영하고 있습니다.
② 개인정보파일의 처리목적‧보유기간 및 항목은 개인정보파일의 특성에 따라 달리 규정하고 있으며, 개인정보파일별 상세한 내용은 아래의 링크를 통해 확인할 수 있습니다.
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
    PrivacyPolicyView()
}
