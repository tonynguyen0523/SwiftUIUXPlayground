//
//  Untitled.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 10/29/24.
//

import SwiftUI

struct FontModifier: ViewModifier {
    var fontType: FontType = .regular
    
    enum FontType {
        case regular
        case bold
        case toolbar
        case title
        case subTitleHeader
        case subtitle
        
        func getFont() -> Font {
            switch self {
            case .regular:
                return .body
            case .bold:
                return .body.weight(.bold)
            case .toolbar:
                return .headline.bold()
            case .title:
                return .title.bold()
            case .subtitle:
                return .subheadline.bold()
            case .subTitleHeader:
                return .title2.bold()
            }
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(fontType.getFont())
            .fontDesign(.rounded)
    }
}

extension View {
    public func regularFont() -> some View {
        self.modifier(FontModifier(fontType: .regular))
    }
    
    public func boldFont() -> some View {
        self.modifier(FontModifier(fontType: .bold))
    }
    
    public func toolbarFont() -> some View {
        self.modifier(FontModifier(fontType: .toolbar))
    }
    
    public func titleFont() -> some View {
        self.modifier(FontModifier(fontType: .title))
    }
    
    public func subTitleHeaderFont() -> some View {
        self.modifier(FontModifier(fontType: .subTitleHeader))
    }
    
    public func subtitleFont() -> some View {
        self.modifier(FontModifier(fontType: .subtitle))
    }
}
