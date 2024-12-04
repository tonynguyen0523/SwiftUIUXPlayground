//
//  HorizontalScrollingButtons.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 12/3/24.
//

import SwiftUI

struct HorizontalScrollingButtons: View {
    var buttons: [RoundedButtonModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(buttons) { button in
                    RoundedButton(model: button)
                }
            }
            .padding(.leading, Paddings.normal)
        }
    }
}

#Preview {
    HorizontalScrollingButtons(buttons: [
        .init(title: "Button 1"),
        .init(title: "Button 2", backgroundColor: .white, foregroundColor: .black, borderColor: .black),
        .init(title: "Button 3", backgroundColor: .white, foregroundColor: .black, borderColor: .black),
        .init(title: "Button 4", backgroundColor: .white, foregroundColor: .black, borderColor: .black),
        .init(title: "Button 5", backgroundColor: .white, foregroundColor: .black, borderColor: .black),
    ])
}
