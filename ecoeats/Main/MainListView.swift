//
//  MainListView.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        VStack {
            Spacer(minLength: 70)
            List(dataController.stores) { store in
                NavigationLink(destination: {
                    StoreDetails(store: store)
                }) {
                    StoreRow(store: store)
                }
            }.refreshable(action: {
                withAnimation {
                    dataController.stores = []
                    dataController.getStores { error in }
                }
            })
            
            Spacer()
        }
    }
}

#Preview {
    MainListView()
}
