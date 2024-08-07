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
            Text("LIST VIEW")
            List(dataController.stores) { store in
                HStack {
                    AsyncImage(url: URL(string: store.imageUrl)) { result in
                        result.image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                        
                    VStack(alignment: .leading) {
                        Text(store.name)
                            .font(.title)
                        Text(store.address)
                            .font(.body)
                        Text(store.description)
                            .font(.caption)
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    MainListView()
}
