//
//  ScrollingItemDetailScreen.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 9/14/24.
//

import SwiftUI

struct ScrollingItemDetailScreen<Content: View>: View {
    private let content: () -> Content
    private let title: String
    private let headerImage: UIImage?
    private let headerHeight: CGFloat
    private var headerVisibleRatio: CGFloat {
        return max(0, (headerHeight + scrollOffset.y) / headerHeight)
    }
    
    @State private var scrollOffset: CGPoint = .zero
    
    public init(
        title: String,
        headerImage: UIImage? = nil,
        headerHeight: CGFloat = 300.0,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.headerImage = headerImage
        self.headerHeight = headerHeight
        self.content = content
    }
    
    var body: some View {
        GeometryReader { gr in
            ZStack(alignment: .top) {
                ImageTitleHeaderView(
                    title: "\(title)",
                    image: headerImage
                )
                .frame(height: getHeaderHeight())
                .overlay {
                    Color.black.opacity(1 - (headerVisibleRatio))
                }
                .offset(y: scrollOffset.y > 0 ? 0 : scrollOffset.y)
                
                TrackerScrollView {
                    VStack(spacing: 0) {
                        // Spacing to offset scrollview with header height
                        Rectangle()
                            .fill(.clear)
                            .frame(height: headerHeight)

                        content()
                    }
                } onOffsetChange: { offset in
                    scrollOffset = offset
                }
                
//                // TODO: Fix toolbar shadow opacity
//                Rectangle()
//                    .fill(.blue.opacity(calculateTopbarOpacity(topbarHeight: gr.safeAreaInsets.top)))
//                    .shadow(color: .gray.opacity(0.5), radius: 1, x: 0, y: 1)
//                    .frame(width: .infinity, height: gr.safeAreaInsets.top)
            }
            .customToolbar()
            .ignoresSafeArea(edges: .vertical)
        }
    }
    
    func calculateTopbarOpacity(topbarHeight: CGFloat) -> CGFloat {
        if scrollOffset.y >= 0 {
            return 0
        }
        
        let updatedHeaderHeight = headerHeight - topbarHeight
        return 1 - (max(0, (updatedHeaderHeight + scrollOffset.y) / (updatedHeaderHeight)))
    }
    
    func getHeaderHeight() -> CGFloat {
        if scrollOffset.y >= 0 {
            return headerHeight + scrollOffset.y
        }
        
        return headerHeight
    }
}

#Preview {
    NavigationView {
        GeometryReader { proxy in
            ScrollingItemDetailScreen(
                title: "Toolbar View",
                headerImage: UIImage(named: "rayimage"),
                headerHeight: 300.0
            ) {
                VStack {
    
                }
                .background(.white)
            }
        }
    }
}
