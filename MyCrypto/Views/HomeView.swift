//
//  HomeView.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var timeVm: TimeViewModel
    @ObservedObject var ticker24Vm: Ticker24ViewModel
    @ObservedObject var candleVm: CandleViewModel
    @ObservedObject var tickerSocketVm: TickerSocketViewModel
    @ObservedObject var klineSocketVM: KlineSocketViewModel
    
    @Binding var selectedSymbol: String
    @Binding var selectedInterval: String
    @Binding var searchText: String
    
    let symbols: [String]
    let intervals: [String]
    
    let onIntervalChange: (String) -> Void
    let onSymbolChange: (String) -> Void
    
    var body: some View {
        
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    HeroSummaryCard(
                        serverTime: timeVm.serverTime,
                        symbol: tickerSocketVm.symbol,
                        price: tickerSocketVm.price
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 20)
                    
                    StickySelectors(
                        intervals: intervals,
                        symbols: symbols,
                        selectedInterval: $selectedInterval,
                        selectedSymbol: $selectedSymbol,
                        onIntervalChange: onIntervalChange,
                        onSymbolChange: onSymbolChange
                    )
                    .padding(.bottom, 20)
                    
                    ChartSection(
                        symbol: selectedSymbol,
                        interval: selectedInterval,
                        candles: candleVm.candles
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    
                    MarketSection(
                        searchText: $searchText, tickers: ticker24Vm.filteredTickers
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                }
            }
        }
    }
}
