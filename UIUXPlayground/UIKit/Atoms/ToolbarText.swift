//
//  ToolbarText.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 10/29/24.
//

import SwiftUI

struct ToolbarText: View {
    var title: String
    
    var body: some View {
        Text(title)
            .toolbarFont()
            .lineLimit(1)
    }
}

#Preview {
    ToolbarText(title: "Hello")
}
