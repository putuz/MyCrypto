//
//  SectionHeader.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

// MARK: - Section Header

struct SectionHeader: View {
    let title: String
    let subtitle: String
 
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.textPrimary)
            Text(subtitle)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.textSecondary)
            Spacer()
        }
    }
}

#Preview {
    SectionHeader(title: "exmample", subtitle: "example")
}
