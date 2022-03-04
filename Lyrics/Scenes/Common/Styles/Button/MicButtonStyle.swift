//
//  MicButtonStyle.swift
//  Lyrics
//
//  Created by Leandro Hernandez on 4/3/22.
//

import SwiftUI

struct MicButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    var foregroundColor: Color = Color.black
    
    var backgroundColor: Color = Color.white

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(self.foregroundColor(configuration: configuration))
            .font(.system(size: 17).weight(.bold))
            .frame(width: 60, height: 60, alignment: .center)
            .background(self.backgroundColor(configuration: configuration))
            .cornerRadius(24)
            .shadow(color: Color.blue, radius: 18, x: 0, y: 0)
    }
    
    private func foregroundColor(configuration: Configuration) -> Color {
        if self.isEnabled {
            return configuration.isPressed ? self.foregroundColor.opacity(0.8) : self.foregroundColor
        } else {
            return self.foregroundColor.opacity(0.8)
        }
    }
    
    private func backgroundColor(configuration: Configuration) -> Color {
        if self.isEnabled {
            return configuration.isPressed ? self.backgroundColor.opacity(0.8) : self.backgroundColor
        } else {
            return self.backgroundColor.opacity(0.5)
        }
    }
}
