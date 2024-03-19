//
//  ChatMessageTextField.swift
//  Yana
//
//  Created by serhat on 11.02.2024.
//

import SwiftUI

struct ExpandableTextField: View {
    @Binding var text: String
    @State private var dynamicHeight: CGFloat = 37
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .background(Color.clear)
                .frame(height: dynamicHeight)
                .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.gray, lineWidth: 1))
                .onPreferenceChange(TextViewHeightKey.self) { newHeight in
                    dynamicHeight = newHeight
                }
        }
        .frame(maxHeight: .infinity)
    }
}

struct TextViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

