//
//  ContentView.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 09/06/2026.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject private var timeVm = TimeViewModel()
    @StateObject private var tickerVm = TickerViewModel()
    @StateObject private var ticker24Vm = Ticker24ViewModel()
    @StateObject private var candleVm = CandleViewModel()
    @StateObject private var klineSocketVM = KlineSocketViewModel()
    
    @StateObject private var tickerSocketVm = TickerSocketViewModel()
    
    @State private var selectedSymbol = "BTCUSDT"
    @State private var selectedInterval = "15m"
    
    private let symbols = [
        "BTCUSDT",
        "ETHUSDT",
        "SOLUSDT",
        "XRPUSDT",
    ]
    
    private let intervals = [
        "1m",
        "5m",
        "15m",
        "1h",
        "4h",
        "1d",
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    // MARK: Summary Card
                    SummaryCardView(
                        serverTime: timeVm.serverTime,
                        symbol: tickerSocketVm.symbol,
                        price: tickerSocketVm.price
                    )
                    
                    // MARK: Interval Selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(intervals, id: \.self) { interval in
                                Button {
                                    selectedInterval = interval
                                    
                                    klineSocketVM.connect(symbol: selectedSymbol, interval: interval)
                                    
                                    Task {
                                        await candleVm.load(symbol: selectedSymbol, interval: selectedInterval)
                                    }
                                } label: {
                                    Text(interval.uppercased())
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(selectedInterval == interval ? .blue : .gray.opacity(0.15))
                                        .foregroundStyle(selectedInterval == interval ? .white : .primary)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    
                    // MARK: Symbol Selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(symbols, id: \.self) { symbol in
                                Button {
                                    selectedSymbol = symbol
                                    
                                    tickerSocketVm.connect(symbol: symbol)
                                    
                                    klineSocketVM.connect(symbol: symbol, interval: selectedInterval)
                                    
                                    Task {
                                        await candleVm.load(symbol: symbol, interval: selectedInterval)
                                    }
                                } label: {
                                    Text(symbol)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(selectedSymbol == symbol ? .orange : .gray.opacity(0.15))
                                        .foregroundStyle(selectedSymbol == symbol ? .white : .primary)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    
                    // MARK: Candle Chart
                    
                    CandleSectionView(symbol: selectedSymbol, interval: selectedInterval, candles: candleVm.candles)
                    
                    // MARK: Market Header
                    
                    MarketHeaderView(
                        count: ticker24Vm.ticker24.count
                    )
                    
                    // MARK: Markets
                    LazyVStack(spacing: 12) {
                        
                        ForEach(
                            ticker24Vm.ticker24.prefix(50),
                            id: \.symbol
                        ) { ticker in
                            
                            MarketRowView(
                                ticker: ticker
                            )
                        }
                    }
                }
                .padding()
                .onReceive(
                    klineSocketVM.$latestKline.compactMap{ $0 }
                ) { kline in
                    candleVm.updateLastCandle(from: kline)
                }
            }
            .navigationTitle("MyCrypto")
            .task {
                await timeVm.load()
                await ticker24Vm.load()
                await candleVm.load(symbol: selectedSymbol, interval: selectedInterval)
                
                tickerSocketVm.connect(symbol: selectedSymbol)
                klineSocketVM.connect(symbol: selectedSymbol, interval: selectedInterval)
            }
        }
    }
}

#Preview {
    ContentView()
}
