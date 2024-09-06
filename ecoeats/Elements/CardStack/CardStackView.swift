//
//  CardStackView.swift
//  ecoeats
//
//  Created by Sergey Li on 9/5/24.
//

import SwiftUI

struct CardStackView: View {
    @EnvironmentObject var mainScreenController: MainScreenController
    @State private var rotationAngle: Double = 0
    @State private var offset: CGFloat = 0
    @State private var zIndex: CGFloat = 100
    
    var body: some View {
        
        VStack {
            Spacer()
            ZStack {
                ForEach(Array(mainScreenController.stores.enumerated()), id: \.offset) { index, card in
                    StoreStackElement(store: card)
                        .frame(height: 92)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(.greenMain)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 30)
                        .padding(.horizontal, 20)
                        .padding(.horizontal, CGFloat(index * 20))
                        .offset(y: CGFloat(index * 20))
                        .offset(x: 0, y: index == 0 ? offset: 0)
                        .zIndex(-Double(index))
                        .animation(.default, value: offset)
                        .opacity(index > 2 ? 0 : 1)
                        .onTapGesture {
                            print(index)
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                .onChanged({ gesture in
                                    guard isFrontCard(index) else { return }
                                    if gesture.translation.height < 0 {
                                        offset = gesture.translation.height
                                    }
                                    //                                    rotationAngle = getRotationAgnle()
                                    if offset < -150 {
                                        zIndex = -100
                                    } else {
                                        zIndex = 100
                                    }
                                })
                                .onEnded({ gesture in
                                    guard isFrontCard(index) else { return }
                                    if offset < -150 {
                                        //                                        let width = UIScreen.main.bounds.size.width/2
                                        //                                        withAnimation(.easeInOut(duration: 0.3)) {
                                        //                                            rotationAngle = 360 * (offset.origin.x < width ? 1 : -1)
                                        //                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation {
                                                mainScreenController.stores.removeFirst()
                                                mainScreenController.stores.insert(card, at: mainScreenController.stores.count - 1)
                                                zIndex = 100
                                            }
                                            
                                            //                                            rotationAngle = 0
                                        }
                                        //                                        withAnimation(.easeInOut(duration: 0.2)) {
                                        //                                            offset.size.height -= 100
                                        //                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                offset = .zero
                                            }
                                        }
                                    } else {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            //                                            rotationAngle = 0
                                            offset = .zero
                                        }
                                    }
                                })
                        )
                }
            }
        }
        .padding(.bottom, 50)
    }
    
    private func isFrontCard(_ index: Int) -> Bool {
        index == 0
    }
    
    //    private func getRotationAgnle() -> Double {
    //        let width = UIScreen.main.bounds.size.width/2
    //        return Double(offset.height / 50) * (offset.origin.x < width ? 1 : -1)
    //    }
}

#Preview {
    CardStackView()
}
