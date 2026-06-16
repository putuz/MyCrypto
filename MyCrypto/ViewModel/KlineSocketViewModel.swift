//
//  KlineSocketViewModel.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import Foundation

@MainActor
final class KlineSocketViewModel: ObservableObject {
    
    @Published var latestKline: Kline?
    
    private let socket = KlineSocket()
    
    init() {
        socket.onReceiveTicker =  { kline in
            self.latestKline = kline
        }
    }
    
    func connect(symbol: String, interval: String) {
        socket.connect(symbol: symbol, interval: interval)
    }
    
    func disconnect() {
        socket.disconnect()
    }
}
