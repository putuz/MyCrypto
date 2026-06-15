//
//  Candle.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 12/06/2026.
//

import Foundation

struct Candle: Identifiable, Decodable {
    let id = UUID()
    
    let openTime: Int64
    
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Double
    
    let closeTime: Int64
    let quoteAssetVolume: Double
    let numberOfTrades: Int
    let takerBuyAssetVolume: Double
    let takerBuyQuoteAssetVolume: Double
    let ignore: String
    
    init(openTime: Int64,open: Double,high: Double,low: Double,close: Double,volume: Double,closeTime: Int64,quoteAssetVolume: Double,numberOfTrades: Int,takerBuyAssetVolume: Double,takerBuyQuoteAssetVolume: Double,ignore: String) {
            self.openTime = openTime
            self.open = open
            self.high = high
            self.low = low
            self.close = close
            self.volume = volume
            self.closeTime = closeTime
            self.quoteAssetVolume = quoteAssetVolume
            self.numberOfTrades = numberOfTrades
            self.takerBuyAssetVolume = takerBuyAssetVolume
            self.takerBuyQuoteAssetVolume = takerBuyQuoteAssetVolume
            self.ignore = ignore
        }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        openTime = try container.decode(Int64.self)
        
        open = Double(try container.decode(String.self)) ?? 0
        high = Double(try container.decode(String.self)) ?? 0
        low = Double(try container.decode(String.self)) ?? 0
        close = Double(try container.decode(String.self)) ?? 0
        volume = Double(try container.decode(String.self)) ?? 0
        
        closeTime = try container.decode(Int64.self)
        
        quoteAssetVolume = Double(try container.decode(String.self)) ?? 0
        
        numberOfTrades = try container.decode(Int.self)
        
        takerBuyAssetVolume = Double(try container.decode(String.self)) ?? 0
        
        takerBuyQuoteAssetVolume = Double(try container.decode(String.self)) ?? 0
        
        ignore = try container.decode(String.self)
    }
}

extension Candle {

    var date: Date {
        Date(timeIntervalSince1970: Double(openTime) / 1000)
    }
    var isBullish: Bool {
        close >= open
    }
}

extension Candle {

    static let preview1 = Candle(
        openTime: 1781090000000,
        open: 105000,
        high: 105500,
        low: 104800,
        close: 105300,
        volume: 1234,
        closeTime: 1781090900000,
        quoteAssetVolume: 1000,
        numberOfTrades: 100,
        takerBuyAssetVolume: 500,
        takerBuyQuoteAssetVolume: 600,
        ignore: "0"
    )

    static let preview2 = Candle(
        openTime: 1781090900000,
        open: 105300,
        high: 105700,
        low: 105100,
        close: 105600,
        volume: 1800,
        closeTime: 1781091800000,
        quoteAssetVolume: 1500,
        numberOfTrades: 150,
        takerBuyAssetVolume: 700,
        takerBuyQuoteAssetVolume: 900,
        ignore: "0"
    )

    static let preview3 = Candle(
        openTime: 1781091800000,
        open: 105600,
        high: 106000,
        low: 105400,
        close: 105900,
        volume: 2200,
        closeTime: 1781092700000,
        quoteAssetVolume: 2000,
        numberOfTrades: 180,
        takerBuyAssetVolume: 900,
        takerBuyQuoteAssetVolume: 1200,
        ignore: "0"
    )

    static let preview4 = Candle(
        openTime: 1781092700000,
        open: 105900,
        high: 106200,
        low: 105700,
        close: 105500,
        volume: 2600,
        closeTime: 1781093600000,
        quoteAssetVolume: 2500,
        numberOfTrades: 220,
        takerBuyAssetVolume: 1100,
        takerBuyQuoteAssetVolume: 1400,
        ignore: "0"
    )

    static let preview5 = Candle(
        openTime: 1781093600000,
        open: 105500,
        high: 106500,
        low: 105300,
        close: 106300,
        volume: 3000,
        closeTime: 1781094500000,
        quoteAssetVolume: 3000,
        numberOfTrades: 300,
        takerBuyAssetVolume: 1500,
        takerBuyQuoteAssetVolume: 1800,
        ignore: "0"
    )
}

extension Candle {

    static let previewData: [Candle] = [
        .preview1,
        .preview2,
        .preview3,
        .preview4,
        .preview5
    ]
}
