//
//  BackButton.swift
//  ecoeats
//
//  Created by Sergey Li on 9/2/24.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
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

//#Preview {
//    BackButton()
//}
