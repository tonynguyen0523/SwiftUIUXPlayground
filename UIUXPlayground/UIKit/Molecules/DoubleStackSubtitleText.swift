//
//  DoubleStackHeaderText.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 12/3/24.
//

import SwiftUI

struct DoubleStackSubtitleText: View {
    var title1: String
    var title2: String
    
    var body: some View {
        VStack(alignment: .leading) {
            SubtitleText(title: title1)
            SubtitleText(title: title2)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    DoubleStackSubtitleText(title1: "Title 1", title2: "Title 2")
}
