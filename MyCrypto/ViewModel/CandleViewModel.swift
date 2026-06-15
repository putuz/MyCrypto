//
//  CandleViewModel.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 12/06/2026.
//

import Foundation

@MainActor
final class CandleViewModel: ObservableObject {
    
    @Published var candles: [Candle] = []
    
    private let service: BinanceServiceProtocol
    
    init(service: BinanceServiceProtocol = BinanceService()) {
        self.service = service
    }
    
    func load(symbol: String, interval: String) async {
        do {
            candles = try await service.fetchCandle(symbol: symbol, interval: interval)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateLastCandle(from kline: Kline) {
        guard !candles.isEmpty else { return }
        
        let candle = Candle(
            openTime: kline.openTime,
            open: Double(kline.open) ?? 0,
            high: Double(kline.high) ?? 0,
            low: Double(kline.low) ?? 0,
            close: Double(kline.close) ?? 0,
            volume: Double(kline.volume) ?? 0,
            closeTime: 0,
            quoteAssetVolume: 0,
            numberOfTrades: 0,
            takerBuyAssetVolume: 0,
            takerBuyQuoteAssetVolume: 0,
            ignore: ""
        )
        
        if kline.isClosed {
            candles[candles.count - 1] = candle
            candles.append(candle)
            
            if candles.count > 500 {
                candles.removeFirst()
            }
        } else {
            candles[candles.count - 1] = candle
        }
    }
    
}
