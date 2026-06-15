//
//  BinanceService.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 10/06/2026.
//

import Foundation

final class BinanceService: BinanceServiceProtocol {
    func fetchServerTime() async throws -> Time {
        let url = URL(string: "https://api.binance.com/api/v3/time")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        print(String(data: data, encoding: .utf8) ?? "")
        
        if let http = response as? HTTPURLResponse {
            print("Status:", http.statusCode)
        }
        
        return try JSONDecoder().decode(Time.self, from: data)
    }
    
    func fetchTicker(symbol: String) async throws -> Ticker {
        let url = URL(string: "https://api.binance.com/api/v3/ticker/price?symbol=\(symbol)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        print(String(data: data, encoding: .utf8) ?? "")
        
        if let http = response as? HTTPURLResponse {
            print("Status:", http.statusCode)
        }
        
        return try JSONDecoder().decode(Ticker.self, from: data)
    }
    
    func fetchTicker24() async throws -> [Ticker24] {
        let url = URL(string: "https://api.binance.com/api/v3/ticker/24hr")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
//        print(String(data: data, encoding: .utf8) ?? "")
        
        if let http = response as? HTTPURLResponse {
            print("Status:", http.statusCode)
        }
        
        return try JSONDecoder().decode([Ticker24].self, from: data)
    }
    
    func fetchCandle(symbol: String, interval: String) async throws -> [Candle] {
        let url = URL(string: "https://api.binance.com/api/v3/klines?symbol=\(symbol)&interval=\(interval)&limit=500")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let http = response as? HTTPURLResponse {
            print("Status:", http.statusCode)
        }
        
        return try JSONDecoder().decode([Candle].self, from: data)
    }
}
