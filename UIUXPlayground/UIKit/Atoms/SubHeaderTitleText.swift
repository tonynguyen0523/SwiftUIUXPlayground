//
//  SubHeaderTitleText.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 12/3/24.
//

import SwiftUI

struct SubHeaderTitleText: View {
    var title: String

    var body: some View {
        Text(title)
            .subTitleHeaderFont()
    }
}

#Preview {
    SubHeaderTitleText(title: "Subtitle")
}
