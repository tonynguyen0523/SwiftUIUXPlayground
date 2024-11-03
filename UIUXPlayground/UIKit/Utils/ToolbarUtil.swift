//
//  ToolbarUtil.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 10/29/24.
//

import SwiftUI

struct ToolbarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // Do something
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.white)
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Toolbar Modifier")
                        .font(.headline.bold())
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                        .lineLimit(1)
//                        .opacity(headerVisibleRatio <= 0.4 ? 1.0 : 0.0)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Do something
                    }, label: {
                        Image(systemName: "heart")
                            .foregroundStyle(.white)
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Do something
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.white)
                    })
                }
            }
            .toolbar(.visible, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)
    }
}

extension View {
    func customToolbar() -> some View {
        self.modifier(ToolbarModifier())
    }
}
