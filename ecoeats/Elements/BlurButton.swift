//
//  BackButton.swift
//  ecoeats
//
//  Created by Sergey Li on 9/2/24.
//

import SwiftUI

struct BlurButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .padding(9)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                .environment(\.colorScheme, .dark)
                
        }
    }
}

struct BlurButtonView: View {
    let icon: String
    
    var body: some View {
            Image(icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .padding(9)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                .environment(\.colorScheme, .dark)
    }
}

//#Preview {
//    BackButton()
//}
