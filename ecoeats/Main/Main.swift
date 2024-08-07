//
//  Main.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct Main: View {
    @EnvironmentObject var dataController: DataController
    @State var state: MainState = .list
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                switch state {
                case .map:
                    MapView()
                case .list:
                    MainListView()
                }
                
                Picker("", selection: $state) {
                    ForEach(MainState.allCases) {
                        Text($0.description)
                    }
                }
                .pickerStyle(.segmented)
                .background(.white)
                .padding()
            }
            .navigationTitle(Text("MAIN"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            dataController.getData()
        }
    }
}

#Preview {
    Main()
}
