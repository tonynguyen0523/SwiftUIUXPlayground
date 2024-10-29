//
//  OverlayedImage.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 10/28/24.
//

import SwiftUI

struct OverlayedImage: View {
    var image: UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            let overlayColor: Color = .black.opacity(0.5)
            
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(overlayColor)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            } else {
                Rectangle()
                    .fill(overlayColor)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    OverlayedImage(image: UIImage(named: "rayimage"))
}
