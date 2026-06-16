//
//  MarketSection.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

struct MarketSection: View {
    @Binding var searchText: String
    
    let tickers: [Ticker24]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            SectionHeader(title: "Markets")
            
            TextField("Search coin..", text: $searchText)
                .textFieldStyle(.plain)
                .padding()
                .background(Color.cardBackground)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            
            LazyVStack(spacing: 1) {
                ForEach(tickers, id: \.symbol) { ticker in
                    NavigationLink {
                        CoinDetailView(symbol: ticker.symbol)
                    } label: {
                        MarketRowView(ticker: ticker)
                            .background(Color.cardBackground)
                    }

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

