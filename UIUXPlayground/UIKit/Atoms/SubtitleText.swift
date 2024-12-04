//
//  SubtitleText.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 12/3/24.
//

import SwiftUI

struct SubtitleText: View {
    var title: String
    
    var body: some View {
        Text(title)
            .subtitleFont()
    }
}

#Preview {
    SubtitleText(title: "Subtitle")
}
