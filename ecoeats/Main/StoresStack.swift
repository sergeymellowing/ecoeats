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
    
    func offsetForIndex(_ index : Int) -> CGFloat {
        CGFloat((mainScreenController.stores.count - index - 1) * (-16) )
    }
    
    func horizontalPaddingForIndex(_ index : Int) -> CGFloat {
        CGFloat(20 + index * 16)
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
                            HStack {
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
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                
                                VStack(alignment: .leading, spacing: 7) {
                                    Text(store.storeName)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                    Text(store.address)
                                        .font(.system(size: 14))
                                        .foregroundColor(.green100)
                                        .lineLimit(1)
                                }
                                Spacer()
                                
                                VStack {
                                    Spacer()
                                    // TODO: DISTANCE
                                    Text("24.3 km")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.green100)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 5)
                                        .background(.green900)
                                        .cornerRadius(8)
                                }
                            }
                            
                            //                        .frame(height: 92)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(.greenMain)
                            .cornerRadius(12)
                            .padding(.horizontal, horizontalPaddingForIndex(index))
                            .shadow(color: .black.opacity(0.2), radius: 30)
                            //                        .offset(x: 0, y: offsetForIndex(index) + (self.dragOffset * CGFloat(3 - index)))
                            .offset(x: 0, y: offsetForIndex(index) + (index == 0 ? self.dragOffset : self.dragOffset * 0.3))
                            .zIndex(Double(-index))
                        }
                        
                    }
                }
                .frame(height: CGFloat(100 + 12))
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
                            
                            if let firstElement = mainScreenController.stores.first {
                                withAnimation {
                                    mainScreenController.stores.removeFirst()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation {
                                        mainScreenController.stores.append(firstElement)
                                        if let first = mainScreenController.stores.first {
                                            mainScreenController.selectStore(store: first)
                                        }
                                        self.dragOffset = 0
                                        print(mainScreenController.stores.count)
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
    }
}
