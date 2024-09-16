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
    
    public init(
        title: String,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                ScrollView {
                    VStack(spacing: 0) {
                        ImageTitleHeaderView(
                            title: title,
                            defaultHeight: proxy.size.height / 2.8
                        )
                        
                        content()
                            .frame(width: proxy.size.width)
                    }
                }
                .withTracking { offset in
                    //
                }
            }
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
        .background(.black)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        ScrollingItemDetailScreen(title: "Empower Excellence Employee Development Day") {
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
