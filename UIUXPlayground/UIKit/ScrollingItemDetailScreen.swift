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
                // TODO: Fix drag down not sticking to under header. Looks like its staying under the image since the image is being streched more than the header.
                ScrollView(showsIndicators: false) {
                    ZStack(alignment: .top) {
                        ScrollViewTracker()
                        
                        VStack(spacing: 0) {
                            ImageTitleHeaderView(
                                title: title,
                                image: headerImage,
                                defaultHeight: headerHeight
                            )
                            .overlay {
                                Color.black.opacity(1 - (headerVisibleRatio))
                            }
                            
                            content()
                        }
                    }
                }
                .withTracker { offset in
                    scrollOffset = offset
                }
                
                // TODO: Fix shadow when pulling down
                Rectangle()
                    .fill(.black.opacity(calculateTopbarOpacity(topbarHeight: gr.safeAreaInsets.top)))
                    .shadow(color: .clear.opacity(calculateTopbarOpacity(topbarHeight: gr.safeAreaInsets.top)), radius: 1, x: 0, y: 1)
                    .frame(width: .infinity, height: gr.safeAreaInsets.top)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // Do something
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.white)
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline.bold())
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .opacity(headerVisibleRatio < 0.5 ? 1.0 : 0.0)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Do something
                    }, label: {
                        Image(systemName: "heart")
                            .foregroundStyle(.white)
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Do something
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.white)
                    })
                }
            }
            .ignoresSafeArea(edges: .vertical)
            .toolbar(.visible, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
    
    func calculateTopbarOpacity(topbarHeight: CGFloat) -> CGFloat {
        let updatedHeaderHeight = headerHeight - topbarHeight
        return 1 - (max(0, (updatedHeaderHeight + scrollOffset.y) / (updatedHeaderHeight)))
    }
}

#Preview {
    NavigationView {
        GeometryReader { proxy in
            ScrollingItemDetailScreen(
                title: "Empower Excellence Employee Development Day",
                headerImage: UIImage(named: ""),
                headerHeight: 300.0
            ) {
                VStack {
                    InfoCell(title: "Type", description: "Ground, Rock")
                    InfoCell(title: "Abilities", description: "Lightning Rod or Rock Head, Reckless (Hidden Ability)")
                    InfoCell(title: "Gender Ratio", description: "50% male,50% female")
                    InfoCell(title: "Catch Rate", description: "60%")
                    InfoCell(title: "Egg Group", description: "Monster and Field")
                    InfoCell(title: "Hatch time", description: "20 cycles")
                    InfoCell(title: "Leveling rate", description: "Slow")
                    InfoCell(title: "Weight", description: "Big Boi")
                    InfoCell(title: "Color", description: "Gray")
                    InfoCell(title: "Description", description: "Rhydon is a large, gray, bipedal Pokémon with features similar to both dinosaurs and rhinoceroses. It has narrow, red eyes and two fangs in its upper jaw. On the tip of Rhydon's snout is a cream-colored horn, which is smaller on a female than on a male.")
                }
                .background(.white)
            }
        }
    }
}
