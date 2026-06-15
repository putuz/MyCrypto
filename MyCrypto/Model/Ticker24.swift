//
//  Ticker24.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 11/06/2026.
//

import Foundation

struct Ticker24: Codable {
    let symbol: String
    let priceChange: String
    let priceChangePercent: String
    let weightedAvgPrice: String
    let prevClosePrice: String
    let lastPrice: String
    let lastQty: String
    let bidPrice: String
    let bidQty: String
    let askPrice: String
    let askQty: String
    let openPrice: String
    let highPrice: String
    let lowPrice: String
    let volume: String
    let quoteVolume: String
    let openTime: Int64
    let closeTime: Int64
    let firstId: Int
    let lastId: Int
    let count: Int
}
