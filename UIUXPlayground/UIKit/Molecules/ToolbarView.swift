//
//  ToolbarView.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 10/29/24.
//

import SwiftUI

struct ToolbarView: View {
    var title: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ToolbarButton(uiImage: UIImage(systemName: "arrow.left")) {
                // Do nothing
            }
            
            ToolbarText(title: title)
                .frame(maxWidth: .infinity)

            ToolbarButton(uiImage: UIImage(systemName: "heart")) {
                // Do nothing
            }

            ToolbarButton(uiImage: UIImage(systemName: "square.and.arrow.up")) {
                // Do nothing
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    ToolbarView(title: "Toolbar View")
}
