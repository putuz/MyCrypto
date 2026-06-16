//
//  HeroSummaryCard.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

struct HeroSummaryCard: View {
    let serverTime: String
    let symbol: String
    let price: String
 
    @State private var pulse = false
 
    var body: some View {
        ZStack {
            // Background gradient
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#0F1E3D"), Color(hex: "#0A0E1A")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
 
            // Blue glow behind price
            Ellipse()
                .fill(Color.accentBlue.opacity(0.12))
                .frame(width: 260, height: 120)
                .blur(radius: 40)
                .offset(x: 20, y: 0)
 
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.cardBorder, lineWidth: 1)
 
            VStack(alignment: .leading, spacing: 0) {
 
                // Top row
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("SPOT")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color.accentBlue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.accentBlue.opacity(0.15))
                            .clipShape(Capsule())
 
                        Text(symbol.isEmpty ? "BTCUSDT" : symbol)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(Color.textPrimary)
                    }
 
                    Spacer()
 
                    // Live price badge
                    HStack(spacing: 5) {
                        Circle()
                            .fill(Color.accentGreen)
                            .frame(width: 7, height: 7)
                            .scaleEffect(pulse ? 1.3 : 1.0)
                            .animation(.easeInOut(duration: 0.8).repeatForever(), value: pulse)
                        Text("Real-time")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color.accentGreen)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.accentGreen.opacity(0.1))
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.accentGreen.opacity(0.3), lineWidth: 1))
                }
 
                Spacer().frame(height: 20)
 
                // Price display
                HStack(alignment: .bottom, spacing: 6) {
                    Text(price.isEmpty ? "—" : price)
                        .font(.system(size: 36, weight: .heavy, design: .monospaced))
                        .foregroundStyle(Color.textPrimary)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
 
                    Text("USDT")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.textSecondary)
                        .padding(.bottom, 4)
                }
 
                Spacer().frame(height: 16)
 
                Divider()
                    .background(Color.cardBorder)
 
                Spacer().frame(height: 12)
 
                // Footer
                HStack {
                    Label {
                        Text(serverTime.isEmpty ? "--:--:--" : serverTime)
                            .font(.system(size: 11, weight: .medium, design: .monospaced))
                            .foregroundStyle(Color.textSecondary)
                    } icon: {
                        Image(systemName: "clock")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.textTertiary)
                    }
 
                    Spacer()
 
                    Text("Binance · Spot")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.textTertiary)
                }
            }
            .padding(20)
        }
        .onAppear { pulse = true }
    }
}

#Preview {
    HeroSummaryCard(serverTime: "", symbol: "btc", price: "10")
}
