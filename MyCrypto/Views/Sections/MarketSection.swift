//
//  MarketSection.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

struct MarketSection: View {

    let tickers: [Ticker24]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            SectionHeader(
                title: "Markets",
                subtitle: "\(tickers.count) pairs"
            )

            MarketHeaderView(count: 5)

            LazyVStack(spacing: 1) {
                ForEach(tickers.prefix(50), id: \.symbol) { ticker in
                    MarketRowView(ticker: ticker)
                        .background(Color.cardBackground)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.cardBorder, lineWidth: 1)
            )
        }
    }
}

