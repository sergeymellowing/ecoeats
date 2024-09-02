//
//  BackgroundClearView.swift
//  ecoeats
//
//  Created by Sergey Li on 9/2/24.
//

import SwiftUI

struct ClearBackgroundView: UIViewRepresentable {
    @MainActor
    private static var backgroundColor: UIColor?

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        Task {
            Self.backgroundColor = view.superview?.superview?.backgroundColor
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        uiView.superview?.superview?.backgroundColor = Self.backgroundColor
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground()->some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}
