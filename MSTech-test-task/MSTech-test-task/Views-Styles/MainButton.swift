//
//  MainButton.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import SwiftUI

struct MainButton: View {
    let text: String
    let disabled: Bool
    let foregroundStyle: Color
    let backgroundColor: Color
    let action: () -> ()
    
    init(
        text: String,
        disabled: Bool,
        foregroundStyle: Color = .white,
        backgroundColor: Color = .appPurple4,
        action: @escaping () -> ()
    ) {
        self.text = text
        self.foregroundStyle = foregroundStyle
        self.backgroundColor = backgroundColor
        self.action = action
        self.disabled = disabled
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundStyle(foregroundStyle)
                .font(.system(size: 19, weight: .bold))
                .frame(maxWidth: .infinity, minHeight: 52)
                .opacity(disabled ? 0.7 : 1)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(backgroundColor)
                        .opacity(disabled ? 0.4 : 1)
                )
        }
        .disabled(disabled)
        .animation(.easeOut, value: disabled)
    }
}

#Preview {
    ZStack {
        MainButton(
            text: "Log In".uppercased(),
            disabled: false,
            action: { }
        )
    }
    .padding()
}
