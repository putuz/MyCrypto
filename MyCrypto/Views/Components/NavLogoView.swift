//
//  NavLogoView.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

// MARK: - Nav Logo

struct NavLogoView: View {
    var body: some View {
        HStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(Color.accentBlue)
                    .frame(width: 26, height: 26)
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
            }
            Text("MyCrypto")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.textPrimary)
        }
    }
}

#Preview {
    NavLogoView()
}
