//
//  TestView.swift
//  ecoeats
//
//  Created by Sergey Li on 9/5/24.
//

import SwiftUI

struct TestView: View {
    @State var currentIndex: Int = 0
//    @GestureState var dragOffset: CGFloat = 0
    @State var dragOffset: CGFloat = 0
    private var images: [String] = ["1", "2", "3", "4", "5"]
    
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .frame(width: 300, height: 300)
                        .background(Color.black)
                        .cornerRadius(30)
//                        .opacity(currentIndex == index ? 1 : 0.5)
                        .scaleEffect(currentIndex == index ? 1 : 0.8)
                        .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset)
                    
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        let threshold: CGFloat = 80
                        if value.translation.width > threshold {
                            withAnimation {
                                self.dragOffset = 0
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                self.dragOffset = 0
                                currentIndex = min(images.count - 1, currentIndex + 1)
                            }
                        } else {
                            withAnimation {
                                self.dragOffset = 0
                            }
                        }
                    }
            )
        }
    }
}

#Preview {
    TestView()
}
