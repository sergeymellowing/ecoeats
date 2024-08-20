//
//  Main.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct Main: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var appController: AppController
    @StateObject var mainScreenController = MainScreenController()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                switch mainScreenController.state {
                case .map:
                    MapView()
                case .list:
                    MainListView()
                }
                
                ZStack {
                    HStack {
                        Picker("", selection: $mainScreenController.state) {
                            ForEach(MainState.allCases) {
                                Text($0.description)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: UIScreen.main.bounds.width / 3)
                    }.frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        NavigationLink(destination: {
                            AccountView()
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
//        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            dataController.getStores(lookAround: appController.apiUser == nil) { error in }
        }
        .environmentObject(mainScreenController)
        .environmentObject(locationManager)
    }
}

#Preview {
    Main()
}
