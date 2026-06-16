//
//  ChartSection.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

struct ChartSection: View {

    let symbol: String
    let interval: String
    let candles: [Candle]

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            SectionHeader(
                title: "Price Chart",
                subtitle: "\(symbol) · \(interval.uppercased())"
            )

            CandleSectionView(
                symbol: symbol,
                interval: interval,
                candles: candles
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
        }
    }
}
