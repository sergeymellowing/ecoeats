//
//  Onboarding.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct Onboarding: View {
    @EnvironmentObject var appController: AppController
    @AppStorage("isAppOnboarded") private var isAppOnboarded = Defaults.isAppOnboarded
    @State var currentTabIndex: Int = 0
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(0..<5) { index in
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(currentTabIndex == index ? .green100 : .green1000)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                
                TabView(selection: $currentTabIndex) {
                    ForEach(0..<5) { index in
                        OnboardingView(index: index, currentTabIndex: $currentTabIndex)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page)
            }
            .frame(maxWidth: .infinity)
            .background(Color.greenMain)
            
//            Text("ONBOARDING")
//                .navigationBarItems(trailing:
//                                        Button(action: {
//                    DispatchQueue.main.async {
//                        withAnimation {
//                            self.isAppOnboarded = true
//                            appController.appState = .signin
//                        }
//                    }
//                }) {
//                    Text("skip")
//                }
//                )
        }
    }
}

#Preview {
    Onboarding()
}
