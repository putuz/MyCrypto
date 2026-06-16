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
    @StateObject private var ticker24Vm = Ticker24ViewModel()
    @StateObject private var candleVm = CandleViewModel()
    @StateObject private var tickerSocketVm = TickerSocketViewModel()
    @StateObject private var klineSocketVM = KlineSocketViewModel()
    
    @State private var selectedSymbol = "BTCUSDT"
    @State private var selectedInterval = "15m"
    
    private let symbols = [
        "BTCUSDT",
        "ETHUSDT",
        "SOLUSDT",
        "XRPUSDT"
    ]
    
    private let intervals = [
        "1m",
        "5m",
        "15m",
        "1h",
        "4h",
        "1d"
    ]
    
    var body: some View {
        
        NavigationStack {
            
            HomeView(
                timeVm: timeVm,
                ticker24Vm: ticker24Vm,
                candleVm: candleVm,
                tickerSocketVm: tickerSocketVm,
                klineSocketVM: klineSocketVM,
                selectedSymbol: $selectedSymbol,
                selectedInterval: $selectedInterval, searchText: $ticker24Vm.searchText,
                symbols: symbols,
                intervals: intervals,
                onIntervalChange: { interval in
                    klineSocketVM.connect(
                        symbol: selectedSymbol,
                        interval: interval
                    )
                    
                    Task {
                        await candleVm.load(
                            symbol: selectedSymbol,
                            interval: interval
                        )
                    }
                },
                onSymbolChange: { symbol in
                    
                    tickerSocketVm.connect(symbol: symbol)
                    
                    klineSocketVM.connect(
                        symbol: symbol,
                        interval: selectedInterval
                    )
                    
                    Task {
                        await candleVm.load(
                            symbol: symbol,
                            interval: selectedInterval
                        )
                    }
                }
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(
                    placement: .navigationBarLeading
                ) {
                    NavLogoView()
                }
                
                ToolbarItem(
                    placement: .navigationBarTrailing
                ) {
                    NavActionsView(
                        serverTime: timeVm.serverTime
                    )
                }
            }
            .toolbarBackground(
                Color.appBackground,
                for: .navigationBar
            )
            .toolbarBackground(
                .visible,
                for: .navigationBar
            )
            .onReceive(klineSocketVM.$latestKline.compactMap { $0 }) { kline in
                candleVm.updateLastCandle(from: kline)
            }
            .task {
                
                await timeVm.load()
                
                await ticker24Vm.load()
                
                await candleVm.load(
                    symbol: selectedSymbol,
                    interval: selectedInterval
                )
                
                tickerSocketVm.connect(
                    symbol: selectedSymbol
                )
                
                klineSocketVM.connect(
                    symbol: selectedSymbol,
                    interval: selectedInterval
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
