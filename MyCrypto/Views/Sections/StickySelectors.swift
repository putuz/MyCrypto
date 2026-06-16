//
//  StickySelectors.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

struct StickySelectors: View {
    let intervals: [String]
    let symbols: [String]
    @Binding var selectedInterval: String
    @Binding var selectedSymbol: String
    let onIntervalChange: (String) -> Void
    let onSymbolChange: (String) -> Void
 
    var body: some View {
        VStack(spacing: 0) {
 
            // Symbol picker
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(symbols, id: \.self) { symbol in
                        SymbolChip(
                            symbol: symbol,
                            isSelected: selectedSymbol == symbol
                        ) {
                            selectedSymbol = symbol
                            onSymbolChange(symbol)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 10)
 
            // Interval picker
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(intervals, id: \.self) { interval in
                        IntervalChip(
                            interval: interval,
                            isSelected: selectedInterval == interval
                        ) {
                            selectedInterval = interval
                            onIntervalChange(interval)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    StickySelectors(
            intervals: ["15m", "1h", "4h", "1d", "1w"],
            symbols: ["BTC", "ETH", "BNB", "SOL", "XRP"],
            selectedInterval: .constant("1h"),
            selectedSymbol: .constant("BTC"),
            onIntervalChange: { _ in },
            onSymbolChange: { _ in }
        )
}
