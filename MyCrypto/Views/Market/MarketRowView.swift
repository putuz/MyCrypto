//
//  MarketRowView.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 12/06/2026.
//

import SwiftUI

struct MarketRowView: View {
    
    let ticker: Ticker24
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(ticker.symbol)
                    .font(.headline)
                
                Text("Vol \(ticker.volume)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(ticker.lastPrice)
                    .fontWeight(.semibold)
                
                Text("\(ticker.priceChangePercent)%")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle((Double(ticker.priceChangePercent) ?? 0) >= 0 ? .green : .red)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}

#Preview {
    MarketRowView(
        ticker: Ticker24(
            symbol: "BTCUSDT",
            priceChange: "1200",
            priceChangePercent: "2.35",
            weightedAvgPrice: "104000",
            prevClosePrice: "104000",
            lastPrice: "105200",
            lastQty: "0.001",
            bidPrice: "105190",
            bidQty: "1.2",
            askPrice: "105210",
            askQty: "0.8",
            openPrice: "104000",
            highPrice: "106000",
            lowPrice: "103000",
            volume: "12345",
            quoteVolume: "1280000000",
            openTime: 1781090000000,
            closeTime: 1781099999999,
            firstId: 1,
            lastId: 100,
            count: 5000
        )
    )
}
