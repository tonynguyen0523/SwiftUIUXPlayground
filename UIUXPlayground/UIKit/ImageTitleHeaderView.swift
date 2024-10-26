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
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                if let uiImage = image{
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.55))
                    
                    Text(title)
                        .font(.title.bold())
                        .foregroundStyle(.white)
                        .padding(20)
                        .frame(width: proxy.size.width, alignment: .bottomLeading)
                }
            }
        }
    }
}

#Preview {
    ImageTitleHeaderView(title: "Epic Moments Productions", image: UIImage(named: "rayimage"))
}
