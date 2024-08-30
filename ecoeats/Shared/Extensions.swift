//
//  Extensions.swift
//  ecoeats
//
//  Created by 이준녕 on 8/26/24.
//

import SwiftUI
import Foundation

extension Color {
//    static let greenMain = Color("green-main")
//    static let blue500 = Color("blue-500")
//    static let gray800 = Color("gray-800")
//    static let green100 = Color("green-100")
//    static let green200 = Color("green-200")
//    static let green500 = Color("green-500")
//    static let green800 = Color("green-800")
//    static let red500 = Color("red-500")
//    static let yellow200 = Color("yellow-200")
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
