//
//  StoreDetails.swift
//  ecoeats
//
//  Created by 이준녕 on 8/16/24.
//

import SwiftUI
import CachedAsyncImage

struct StoreDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var mainScreenController: MainScreenController
    @EnvironmentObject var appController: AppController
    @EnvironmentObject var locationManager: LocationManager
    
    let store: Store
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topLeading) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .bottom) {
                            CachedAsyncImage(
                                url: "https://picsum.photos/200/300",
                                placeholder: { progress in
                                    // Create any view for placeholder (optional).
                                    ZStack {
                                        ProgressView() {
                                            VStack {
                                                Text("\(progress) %")
                                            }
                                        }
                                    }
                                },
                                image: {
                                    // Customize image.
                                    Image(uiImage: $0)
                                        .resizable()
                                        .scaledToFill()
                                }
                            )
                            .frame(maxWidth: .infinity)
                            .frame(height: 275)
                            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .black, .clear, .clear]), startPoint: .top, endPoint: .bottom))
                            
                            CachedAsyncImage(
                                url: "https://picsum.photos/200/300",
                                placeholder: { progress in
                                    // Create any view for placeholder (optional).
                                    ZStack {
                                        ProgressView() {
                                            VStack {
                                                Text("\(progress) %")
                                            }
                                        }
                                    }
                                },
                                image: {
                                    // Customize image.
                                    Image(uiImage: $0)
                                        .resizable()
                                        .scaledToFill()
                                }
                            )
                            .frame(width: 128, height: 128)
                            .cornerRadius(15)
                        }
                        
                        VStack(spacing: 12) {
                            Text(store.storeName)
                                .font(.system(size: 24, weight: .bold))
                            
                            
                            Text(store.description)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                            
                            HStack {
                                Text("~8:30 pm")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.green100)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 5)
                                    .background(.green900)
                                    .cornerRadius(8)
                                    .padding(.trailing, 5)
                                    .padding(.bottom, 10)
                                
                                Text("1.3 km")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.green100)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 5)
                                    .background(.green900)
                                    .cornerRadius(8)
                                    .padding(.bottom, 10)
                            }
                            .padding(.bottom,20)
                            
                            HStack {
                                Image("ic-location")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                                Text(store.address)
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray800)
                                Spacer()
                                Button(action: {
                                    DispatchQueue.main.async {
                                        mainScreenController.state = .map
                                        mainScreenController.setRegion(lat: store.location.latitude, lng: store.location.longitude)
                                    }
                                }) {
                                    Text("지도에서 보기")
                                        .underline()
                                        .font(.system(size: 14))
                                        .foregroundColor(.green200)
                                }
                            }
                            
                            HStack {
                                Button(action: {
                                    let telephone = "tel://"
                                    let formattedString = telephone + store.phoneNumber.replacingOccurrences(of: "-", with: "")
                                    guard let url = URL(string: formattedString) else { return }
                                    UIApplication.shared.open(url)
                                }) {
                                    Image("ic-phone")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12, height: 12)
                                    Text(store.phoneNumber)
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray800)
                                        .padding(.trailing)
                                    //                                Text("복사")
                                    //                                    .underline()
                                    //                                    .font(.system(size: 14))
                                    //                                    .foregroundColor(.green200)
                                }
                                
                                Spacer()
                            }
                            
                            HStack {
                                Image("ic-clock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                                Text("영업시간 | ")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray800)
                                Text(store.openTime)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray800)
                                
                                Spacer()
                                
                                Button(action: {}) {
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12, height: 12)
                                        .foregroundColor(.gray800)
                                }
                            }
                            .padding(.bottom, 50)
                            
                            HStack {
                                Text("오늘 준비된 메뉴")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.bottom, 20)
                            
                            ForEach(store.items) { item in
                                ItemRow(item: item)
                                    .onTapGesture {
                                        if appController.apiUser != nil {
                                            withAnimation {
                                                mainScreenController.selectedItem = item
                                            }
                                        }
                                    }
                                Divider()
                            }
                            //                        .sheet(item: $selectedItem) { item in
                            //                            ItemDetails(item: item, store: store)
                            
                            //                        }
                            Spacer(minLength: 200)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    }
                }
                
                HStack {
                    BlurButton(icon: "ic-chevron.back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    ShareLink(item: URL(string: "https://www.google.com")!) {
                        BlurButtonView(icon: "ic-share")
                    }
                }
                .padding(.top, 74)
                .padding(.horizontal, 20)
            }
            if mainScreenController.selectedItem != nil {
                Color.black.opacity(0.7)
                    .onTapGesture {
                        withAnimation {
                            mainScreenController.selectedItem = nil
                        }
                    }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
//        .overlay(
//            mainScreenController.selectedItem != nil ?
//                ItemDetails(store: store).transition(.move(edge: .bottom))
//            : nil
//        )
    }
}
