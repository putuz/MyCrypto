//
//  IntervalChip.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

struct IntervalChip: View {
    let interval: String
    let isSelected: Bool
    let action: () -> Void
 
    var body: some View {
        Button(action: action) {
            Text(interval.uppercased())
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(isSelected ? Color.accentBlue : Color.textTertiary)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(
                    isSelected
                    ? Color.accentBlue.opacity(0.15)
                    : Color.clear
                )
                .overlay(
                    Capsule()
                        .stroke(
                            isSelected ? Color.accentBlue.opacity(0.6) : Color.cardBorder,
                            lineWidth: 1
                        )
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    IntervalChip(interval: "", isSelected: true, action: {})
}
