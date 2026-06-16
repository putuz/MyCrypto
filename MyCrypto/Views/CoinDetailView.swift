//
//  CoinDetailView.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 16/06/2026.
//

import SwiftUI

struct CoinDetailView: View {
    
    let symbol: String
    
    @StateObject private var timeVm = TimeViewModel()
    @StateObject private var tickerVm = TickerViewModel()
    @StateObject private var candleVm = CandleViewModel()
    @StateObject private var tickerSocketVm = TickerSocketViewModel()
    @StateObject private var klineSocketVm = KlineSocketViewModel()
    
    @State private var selectedInterval = "15m"
    
    private let intervals = [
        "1m",
        "5m",
        "15m",
        "1h",
        "4h",
        "1d",
    ]
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HeroSummaryCard(
                        serverTime: timeVm.serverTime,
                        symbol: symbol,
                        price: tickerSocketVm.price.isEmpty
                        ? tickerVm.price
                        : tickerSocketVm.price
                    )
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(intervals, id: \.self) { interval in
                                Button {
                                    selectedInterval = interval
                                    
                                    Task {
                                        await candleVm.load(symbol: symbol, interval: interval)
                                    }
                                    
                                    klineSocketVm.connect(symbol: symbol, interval: interval)
                                } label: {
                                    Text(interval.uppercased())
                                }
                            }
                        }
                    }
                    
                    CandleSectionView(symbol: symbol, interval: selectedInterval, candles: candleVm.candles)
                }
                .padding()
            }
            .navigationTitle(symbol)
            .onReceive(klineSocketVm.$latestKline.compactMap { $0 }) { kline in
                candleVm.updateLastCandle(from: kline)
            }
            .onDisappear {
                tickerSocketVm.disconnect()
                klineSocketVm.disconnect()
            }
            .task {
                await timeVm.load()
                await tickerVm.load(symbol: symbol)
                await candleVm.load(symbol: symbol, interval: selectedInterval)
                
                tickerSocketVm.connect(symbol: symbol)
                klineSocketVm.connect(symbol: symbol, interval: selectedInterval)
            }
        }
    }
}

#Preview {
    CoinDetailView(symbol: "BTCUSDT")
}
