//
//  BottomButton.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/3/24.
//

import SwiftUI

private struct BottomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .cornerRadius(20)
            .padding(.horizontal, 16)
            .font(.title3)
            .bold()
    }
}

extension View {
    func asBottomButton() -> some View {
        modifier(BottomButton())
    }
}
