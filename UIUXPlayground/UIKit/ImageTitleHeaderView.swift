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
    var maxHeight = 300.0 // Look into this more, Setting to 500.0 will mess somethings up.
    
    @State private var headerHeight: CGFloat = .zero
    @State private var minY: CGFloat = .zero
    
    var body: some View {
        GeometryReader { parentGR in
            ZStack {
                GeometryReader { gr in
                    Color.clear.onChange(of: parentGR.frame(in: .global).minY) { _, newValue in
                        minY = newValue
                        updateHeaderHeight(proxy: gr)
                    }
                    
                    
                    if let uiImage = image{
                        Image(uiImage: uiImage)
                            .resizable()
                            .offset(y: minY > 0 ? minY : 0)
                            .frame(width: gr.size.width, height: headerHeight)
                            .aspectRatio(2, contentMode: .fill)
                    }
                    
                    Rectangle()
                        .fill(.black.opacity(0.5))
                        .frame(width: .infinity, height: headerHeight)
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: .infinity, height: defaultHeight / 2)
                        
                        Text("MinY: \(minY), Height: \(headerHeight)")
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
                    .offset(y: minY > 0 ? minY : 0)
                }
                .offset(y: getOffset(parentProxy: parentGR))
                .frame(height: headerHeight)
            }
        }
        .frame(height: headerHeight)
    }
    
    private func getOffset(parentProxy: GeometryProxy) -> CGFloat {
        let minY = parentProxy.frame(in: .global).minY
        return minY > 0 ? -minY : 0
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
        
        if minY > 0 {
            updatedHeaderHeight += minY
        }
        
        headerHeight = updatedHeaderHeight
    }
}

#Preview {
    ImageTitleHeaderView(title: "Epic Moments Productions", image: UIImage(named: "rayimage"))
}
