//
//  BinanceServiceProtocol.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 10/06/2026.
//

import Foundation

protocol BinanceServiceProtocol {
    func fetchServerTime() async throws -> Time
    func fetchTicker(symbol: String) async throws -> Ticker
    func fetchTicker24() async throws -> [Ticker24]
    func fetchCandle(symbol: String, interval: String) async throws -> [Candle]
}
