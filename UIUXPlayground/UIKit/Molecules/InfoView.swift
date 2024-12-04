//
//  InfoView.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 12/3/24.
//

import SwiftUI

struct InfoView<Content: View>: View {
    private let content: () -> Content
    private var title: String
    
    public init(
        title: String,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: Paddings.large) {
            SubHeaderTitleText(title: title)
            
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    InfoView(title: "Info") {
        SubtitleText(title: "Test")
    }
}
