//
//  SectionHeader.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
 
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.textPrimary)
            Spacer()
        }
    }
}

#Preview {
    SectionHeader(title: "exmample")
}
