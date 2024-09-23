//
//  ImageTitleHeaderView.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 9/14/24.
//

import SwiftUI

struct ImageTitleHeaderView: View {
    var title: String
    var image: UIImage?
    var defaultHeight = 300.0
    var maxHeight = 500.0
    
    @State private var headerHeight: CGFloat = .zero
    
    var body: some View {
        ZStack {
            GeometryReader { gr in
                if let uiImage = image{
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: gr.size.width, height: headerHeight)
                }
                
                Rectangle()
                    .fill(.black.opacity(0.5))
                                
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: .infinity, height: defaultHeight / 2)
                    
                    
                    Text(title)
                        .font(.title.bold())
                        .foregroundStyle(.white)
                        .padding(20)
                        .background(
                            GeometryReader { gr in
                                Color.clear.onAppear {
                                    updateHeaderHeight(proxy: gr)
                                }
                            }
                        )
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, minHeight: defaultHeight / 2, alignment: .bottomLeading)
                }
                
            }
            .background(.gray.opacity(0.5))
            .frame(height: headerHeight)
        }
    }
    
    private func updateHeaderHeight(proxy: GeometryProxy) {
        let splitHeight = defaultHeight / 2
        var textHeight = proxy.size.height
        
        if textHeight < splitHeight {
            textHeight = splitHeight
        }
        
        var updatedHeaderHeight = textHeight + splitHeight
        if updatedHeaderHeight > maxHeight {
            updatedHeaderHeight = maxHeight
        }
        
        headerHeight = updatedHeaderHeight
    }
}

#Preview {
    ImageTitleHeaderView(title: "Epic Moments Productions", image: UIImage(named: "rayimage"))
}
