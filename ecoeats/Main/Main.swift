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
                
                ZStack {
                    HStack {
                        Picker("", selection: $state) {
                            ForEach(MainState.allCases) {
                                Text($0.description)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: UIScreen.main.bounds.width / 3)
                    }.frame(maxWidth: .infinity, alignment: .center)
                    HStack {
                        NavigationLink(destination: {
                            Text("Account View")
                        }) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: 30)
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
            }
//            .navigationTitle(Text("MAIN"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            dataController.getStores { error in }
        }
    }
}

#Preview {
    Main()
}
