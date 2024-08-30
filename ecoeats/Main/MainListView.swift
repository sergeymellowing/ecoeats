//
//  MainListView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var appController: AppController
    @EnvironmentObject var mainScreenController: MainScreenController
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 150 - 55/* safearea*/)
            
            HStack {
                HStack {
                    Text("전체")
                        .foregroundColor(.black)
                    Text(mainScreenController.stores.count.description)
                        .foregroundColor(.greenMain)
                }
                .font(.system(size: 16,weight: .semibold))
                
                Spacer()
                Button(action: {}) {
                    HStack {
                        Text("추천순")
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 16,weight: .medium))
                }
                
            }
            .padding(.horizontal, 10)
            
            Divider()
                .padding(.top, 17)
                
            
            
                ScrollView(showsIndicators: false) {
                    ForEach(mainScreenController.stores) { store in
                    //            List(mainScreenController.stores) { store in
                    NavigationLink(destination: {
                        StoreDetails(store: store)
                    }) {
                        StoreRow(store: store)
                            .padding(.bottom, 20)
                            .padding(.top, 30)
                    }
                }
            }.refreshable(action: {
                withAnimation {
                    mainScreenController.stores = []
                    DataController().getStores(lookAround: appController.apiUser == nil) { stores in
                        if let stores {
                            mainScreenController.stores = stores
                        }
                    }
                }
            })
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .background(.gray100)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainListView()
}
