//
//  TrackerScrollView.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 10/28/24.
//

import SwiftUI

struct TrackerScrollView<Content: View>: View {
    var content: () -> Content
    var onOffsetChange: ((CGPoint) -> Void)?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .top) {
                ScrollViewTracker()
                
                content()
            }
        }
        .withTracker { offset in
            onOffsetChange?(offset)
        }
    }
}

#Preview {
    TrackerScrollView {
        Text("Hello, World!")
    } onOffsetChange: { _ in
        // Do nothing
    }

}
