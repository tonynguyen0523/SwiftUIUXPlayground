//
//  RoundedButton.swift
//  UIUXPlayground
//
//  Created by Tony Nguyen on 12/3/24.
//

import SwiftUI

struct RoundedButtonModel: Identifiable {
    let id: UUID = .init()
    var title: String
    var action: (() -> Void?)?
    var backgroundColor: Color = .red
    var foregroundColor: Color = .white
    var borderColor: Color?
    var icon: UIImage?
}

struct RoundedButton: View {
    var model: RoundedButtonModel
    
    var body: some View {
        Button {
            model.action?()
        } label: {
            HStack {
                if let icon = model.icon {
                    Image(uiImage: icon)
                        .renderingMode(.template)
                        .tint(model.foregroundColor)
                }
                
                SubtitleText(title: model.title)
            }
            .padding()
            .foregroundStyle(model.foregroundColor)
            .background(model.backgroundColor)
            .overlay(content: {
                if let borderColor = model.borderColor {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(borderColor, lineWidth: 3)
                }
            })
            .cornerRadius(6)
        }

    }
}

#Preview {
    RoundedButton(model: .init(title: "Title", action: nil, borderColor: .black, icon: UIImage(systemName: "star")))
}
