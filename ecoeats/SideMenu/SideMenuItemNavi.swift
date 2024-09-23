//
//  SideMenuItemNavi.swift
//  ecoeats
//
//  Created by Sergey Li on 9/23/24.
//

import SwiftUI

struct SideMenuItemNavi: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let title: String
    
    var body: some View {
        HStack {
            BlurButton(icon: "ic-chevron.back", action: {
                presentationMode.wrappedValue.dismiss()
            })
            
            Spacer()
            
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            BlurButton(icon: "ic-chevron.back", action: {
                
            }).opacity(0.0001)
        }
    }
}

#Preview {
    SideMenuItemNavi(title: "")
}
