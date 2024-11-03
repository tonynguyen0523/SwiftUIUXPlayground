//
//  ImageButton.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 10/29/24.
//

import SwiftUI

struct ToolbarButton: View {
    var uiImage: UIImage?
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if let uiImage {
                Image(uiImage: uiImage)
            } else {
                Image(systemName: "heart")
            }
        }
    }
}

#Preview {
    ToolbarButton(uiImage: UIImage(systemName: "square.and.arrow.up")) {
        // Do nothing
    }
}
