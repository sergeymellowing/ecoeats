//
//  LaunchScreen.swift
//  ecoeats
//
//  Created by Sergey Li on 9/11/24.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        VStack(spacing: 22) {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 135, height: 128)
            Text("ECO EATS")
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(.white)
                .overlay(alignment: .bottom, content: {
                    ProgressView()
                        .tint(.white)
                        .offset(y: 50)
                })
                
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.greenMain)
    }
}

#Preview {
    LaunchScreen()
}
