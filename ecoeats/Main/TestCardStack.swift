//
//  TestCardStack.swift
//  ecoeats
//
//  Created by 이준녕 on 8/30/24.
//

import SwiftUI
import CachedAsyncImage

struct StoreStack: View {
    @EnvironmentObject var mainScreenController: MainScreenController
//    @State var data: [Store] = []
    
    var body: some View {
//        VStack {
//            Spacer()
            ZStack(alignment: .bottom) {
                if let store = mainScreenController.selectedStore {
                    ItemsStack(items: store.items)
                }
                CardStack(
                    direction: UpDownDirection.direction,
                    data: mainScreenController.stores,
                    onSwipe: { store, direction in
//                        mainScreenController.stores.append((card))
                        
                        print(mainScreenController.stores.count)
                        print("Swiped \(store.storeName) to \(direction)")
                        mainScreenController.selectStore(store: store)
                    },
                    content: { store, _, _ in
                        StoreCard(store: store)
                    }
                )
                .environment(\.cardStackConfiguration, CardStackConfiguration(
                    maxVisibleCards: 3,
                    swipeThreshold: 0.8,
                    cardOffset: 20,
                    cardScale: 0.1,
                    animation: .linear
                ))
                .padding(.horizontal)
                .scaledToFit()
                .frame(alignment: .bottom)
                .padding(.bottom, 70)
            }
//        }
    }
}

struct StoreCard: View {
  let store: Store

  var body: some View {
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
      .frame(height: 92)
      .frame(maxWidth: .infinity)
      .padding(16)
      .background(.greenMain)
      .cornerRadius(12)
//      .padding(.horizontal, horizontalPaddingForIndex(index))
  }
}
