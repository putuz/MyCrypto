//
//  DesignSystem.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import Foundation
import SwiftUI

// MARK: - Design Tokens
 
extension Color {
    static let appBackground   = Color(hex: "#0A0E1A")
    static let cardBackground  = Color(hex: "#131929")
    static let cardBorder      = Color(hex: "#1E2C45")
    static let accentBlue      = Color(hex: "#2B6EFA")
    static let accentGreen     = Color(hex: "#00D4A1")
    static let accentRed       = Color(hex: "#FF4D6A")
    static let accentOrange    = Color(hex: "#FF9500")
    static let textPrimary     = Color(hex: "#EEF2FF")
    static let textSecondary   = Color(hex: "#6B7FA3")
    static let textTertiary    = Color(hex: "#3D5070")
 
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:(a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red:   Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
