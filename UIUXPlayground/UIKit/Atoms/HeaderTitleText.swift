//
//  HeaderTitleText.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 10/28/24.
//

import SwiftUI

struct HeaderTitleText: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title.bold())
    }
}

#Preview {
    HeaderTitleText(title: "Title")
}
