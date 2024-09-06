//
//  CustomSegmentedControl.swift
//  ecoeats
//
//  Created by Sergey Li on 9/6/24.
//

import SwiftUI

struct CustomSegmentedControl: View {

    @Binding public var selection: MainState
    
    private let size: CGSize = CGSize(width: 130, height: 50)
    private let segmentLabels: [String]
    private var hPadding: CGFloat
    private var vPadding: CGFloat
    private var font: Font
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .background(.ultraThinMaterial)
                .frame(width: size.width, height: size.height)
                .opacity(0.9)
//                .foregroundColor(.black.opacity(0.3))
//                .environment(\.colorScheme, .dark)
            
            /// # Dividers if needed
//            HStack(spacing: 0) {
//                ForEach(0..<segmentLabels.count) { idx in
//                    if idx < (segmentLabels.count - 1) {
//                        customDivider(offset: (segmentWidth(size) - 0.5) * CGFloat(idx + 1), opacity: idx == selection.number - 1 || idx == selection.number ? 0.0 : 1.0)
//                    }
//                }
//            }.animation(Animation.easeOut(duration: 0.8))
            
            // # Selection background
            RoundedRectangle(cornerRadius: 8)
                .frame(width: segmentWidth(size) - (hPadding * 2), height: size.height - (vPadding * 2))
                .foregroundColor(.greenMain.opacity(0.7))
                .offset(x: calculateSegmentOffset(size) + hPadding)
                .animation(Animation.default)
            
            // # Labels
            HStack(spacing: 0) {
                ForEach(0..<segmentLabels.count, id:\.self) { idx in
                    SegmentLabel(title: segmentLabels[idx], width: segmentWidth(size))
                        .onTapGesture {
                            selection = MainState.allCases.first(where: { $0.number == idx }) ?? .list
                        }
                }
            }
        }
    }

    public init(selection: Binding<MainState>,
                segmentLabels: [String],
                hPadding: CGFloat = 5,
                vPadding: CGFloat = 5,
                font: Font = .system(size: 14)
    ) {
        self._selection = selection
        self.segmentLabels = segmentLabels
        self.hPadding = hPadding
        self.vPadding = vPadding
        self.font = font
    }

    private func segmentWidth(_ mainSize: CGSize) -> CGFloat {
        var width = (mainSize.width / CGFloat(segmentLabels.count))
        if width < 0 {
            width = 0
        }
        return width
    }
    
    private func calculateSegmentOffset(_ mainSize: CGSize) -> CGFloat {
        segmentWidth(mainSize) * CGFloat(selection.number)
    }
    
    /// # Creates a Divider for placing between two segments
    private func customDivider(offset: CGFloat, opacity: Double) -> some View {
        Divider()
            .background(Color.white)
            .frame(height: size.height * 0.5) // The height of the divider
            .offset(x: offset)
            .opacity(opacity)
    }
}

fileprivate struct SegmentLabel: View {
    let title: String
    let width: CGFloat
    
    var body: some View {
        
        Image(title)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
//            .font(font)
//            .multilineTextAlignment(.center)
//            .fixedSize(horizontal: false, vertical: false)
            .foregroundColor(.white)
            .frame(width: width)
            .contentShape(Rectangle())
    }
}

//#Preview {
//    CustomSegmentedControl()
//}
