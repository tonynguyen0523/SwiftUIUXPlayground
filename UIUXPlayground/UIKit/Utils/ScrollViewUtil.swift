//
//  ScrollViewUtil.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 9/15/24.
//

import Foundation
import SwiftUI

extension ScrollView {
    func withTracker(
        action: @escaping (_ offset: CGPoint) -> Void
    ) -> some View {
        self
            .coordinateSpace(name: ScrollTrackingNamespace.namespace)
            .onPreferenceChange(ScrollTrackingPreferenceKey.self, perform: action)
    }
}

enum ScrollTrackingNamespace {
    static let namespace = "scrollView"
}

struct ScrollTrackingPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct ScrollViewTracker: View {
    var body: some View {
        GeometryReader { trackerProxy in
            Color.clear
                .preference(
                    key: ScrollTrackingPreferenceKey.self,
                    value: trackerProxy.frame(in: .named(ScrollTrackingNamespace.namespace)).origin
                )
        }
    }
}
