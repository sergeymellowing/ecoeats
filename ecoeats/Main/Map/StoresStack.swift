//
//  StoresStack.swift
//  ecoeats
//
//  Created by 이준녕 on 8/26/24.
//

import SwiftUI
import CachedAsyncImage


struct StoresStack : View {
//    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var mainScreenController: MainScreenController
    @State var dragOffset: CGFloat = 0
    @State var trigerred: Bool = false
    
    func offsetForIndex(_ index : Int) -> CGFloat {
        if self.trigerred {
            CGFloat((mainScreenController.stores.count - index) * (-16)) + (index == 0 ? 16 * 3 : 0)
        } else {
            CGFloat((mainScreenController.stores.count - index - 1) * (-16)) + (index == 0 ? self.dragOffset : 0)
        }
        
    }
    
    func horizontalPaddingForIndex(_ index : Int) -> CGFloat {
        if self.trigerred {
            CGFloat(20 + (index - 1) * 16) + (index == 0 ? (3 * 16) : 0)
        } else {
            CGFloat(20 + index * 16)
        }
        
    }
    
    func triggerValue(_ index : Int) -> Double {
        if self.trigerred {
            if index == 0 {
                100
            } else {
                0
            }
        } else {
            0
        }
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .bottom) {
                if let store = mainScreenController.selectedStore {
                    ItemsStack(items: store.items)
                }
//                VStack {
//                    Text("이베리코 포크 플레이트")
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(.black)
//                    
//                    Text("건강한 재료들로 내 몸을 가득 채워보세요")
//                        .font(.system(size: 14))
//                        .foregroundColor(.gray)
//                }
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 200)
//                    .background(Color.white)
//                    .cornerRadius(20)
//                    .shadow(radius: 15)
//                    .padding(.horizontal, 60)
//                    .padding(.bottom, 100)
                
                
                GeometryReader { reader in
                    ForEach(Array(mainScreenController.stores.enumerated()), id: \.offset) { index, store in
                        if index < 3 {
                            StoreStackElement(store: store)
                            
                            //                        .frame(height: 92)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(.greenMain)
                            .cornerRadius(12)
                            .padding(.horizontal, horizontalPaddingForIndex(index))
                            .shadow(color: .black.opacity(0.2), radius: 30)
                            //                        .offset(x: 0, y: offsetForIndex(index) + (self.dragOffset * CGFloat(3 - index)))
                            .offset(x: 0, y: offsetForIndex(index))
                            .zIndex(Double(-index) - triggerValue(index))
                            
                        }
                        
                    }
                }
                .frame(height: CGFloat(100 + 12))
                .onTapGesture {
                    if mainScreenController.selectedStore != nil {
                        mainScreenController.navigateToStoreDetails = true
                    }
                }
                .gesture(DragGesture()
                    .onChanged { gesture in
                        //                    print(gesture.translation.height)
                        if gesture.translation.height < 0 {
                            self.dragOffset = gesture.translation.height * 0.4
                        }
                    }
                    .onEnded { gesture in
                        if gesture.translation.height > -200 {
                            withAnimation {
                                self.dragOffset = 0
                            }
                        } else {
                            print("switch")
                            
                            DispatchQueue.main.async {
                                if let firstElement = mainScreenController.stores.first {
                                    withAnimation {
                                        self.trigerred = true
                                        self.dragOffset = 0
                                    }
                                    
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        mainScreenController.stores.removeFirst()
                                        mainScreenController.stores.append(firstElement)
                                        self.trigerred = false
                                        if let first = mainScreenController.stores.first {
                                            mainScreenController.selectStore(store: first)
                                        }
                                    }
                                }
                            }
                            
                        }
                    })
            }
        }
        .padding(.bottom, 30)
        .onAppear {
            //            self.threeStores = Array(dataController.stores.prefix(3))
        }
        //        .onChange(of: selectedStore) { newStore in
        //            self.boxes = [
        //                StoreBox(id: 0, store: newStore),
        //                StoreBox(id: 1),
        //                StoreBox(id: 2)
        //            ]
        //        }
        .background(
            NavigationLink(isActive: $mainScreenController.navigateToStoreDetails, destination: {
                if let store = mainScreenController.selectedStore {
                    StoreDetails(store: store)
                } else {
                    Text("Oops. Something went wrong...")
                }
            }) {
                EmptyView()
            }
        )
    }
}
