//
//  Main.swift
//  ecoeats
//
//  Created by 이준녕 on 8/6/24.
//

import SwiftUI

struct Main: View {
//    @EnvironmentObject var dataController: DataController
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
                        Button(action: {
                            mainScreenController.currentLocationOn.toggle()
                            if mainScreenController.currentLocationOn, 
                                let coorditate = locationManager.lastLocation?.coordinate,
                               mainScreenController.region.center.latitude != coorditate.latitude,
                               mainScreenController.region.center.longitude != coorditate.longitude
                            {
                                withAnimation {
                                    mainScreenController.setRegion(lat: coorditate.latitude, lng: coorditate.longitude)
                                }
                            }
                        }) {
                            Image(systemName: "location")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .frame(width: 42, height: 42)
                                .background(mainScreenController.currentLocationOn ? .green800.opacity(0.8) : .gray800.opacity(0.6))
                                .cornerRadius(8)
                                .opacity(mainScreenController.state == .map ? 1 : 0)
                        }
                            
                        
                        Spacer()
                        
                        Picker("", selection: $mainScreenController.state) {
                            ForEach(MainState.allCases) {
                                Image("ic-\($0.description)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
//                                Text($0.description)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: UIScreen.main.bounds.width / 3, height: 50)
                        
                        Spacer()
                        
                        HStack {
                            NavigationLink(destination: {
                                AccountView()
                            }) {
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .frame(width: 42, height: 42)
                                    .background(.green800.opacity(0.8))
                                    .cornerRadius(8)
                                    
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }
//            .navigationTitle(Text("MAIN"))
            .navigationBarTitleDisplayMode(.inline)
        }
//        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            DataController().getStores(lookAround: appController.apiUser == nil) { stores in
                if let stores {
                    DispatchQueue.main.async {
                        mainScreenController.stores = stores
                    }
                }
            }
        }
        .environmentObject(mainScreenController)
        .environmentObject(locationManager)
    }
}

#Preview {
    Main()
}
