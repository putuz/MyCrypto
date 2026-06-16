//
//  SymbolChip.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

struct SymbolChip: View {
    let symbol: String
    let isSelected: Bool
    let action: () -> Void
 
    // Strip USDT for display
    private var baseAsset: String {
        symbol.replacingOccurrences(of: "USDT", with: "")
    }
 
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                // Colored dot per asset
                Circle()
                    .fill(assetColor)
                    .frame(width: 8, height: 8)
 
                Text(baseAsset)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(isSelected ? .white : Color.textSecondary)
 
                Text("/USDT")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(isSelected ? .white.opacity(0.6) : Color.textTertiary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(
                isSelected
                ? assetColor.opacity(0.25)
                : Color.cardBackground
            )
            .overlay(
                Capsule()
                    .stroke(
                        isSelected ? assetColor.opacity(0.8) : Color.cardBorder,
                        lineWidth: 1
                    )
            )
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
 
    private var assetColor: Color {
        switch symbol {
        case "BTCUSDT":  return Color(hex: "#F7931A")
        case "ETHUSDT":  return Color(hex: "#627EEA")
        case "SOLUSDT":  return Color(hex: "#9945FF")
        case "XRPUSDT":  return Color(hex: "#00AAE4")
        default:         return Color.accentBlue
        }
    }
}

#Preview {
    SymbolChip(symbol: "", isSelected: true, action: {})
}
