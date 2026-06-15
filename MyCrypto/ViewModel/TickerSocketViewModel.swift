//
//  TickerSocketViewModel.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 13/06/2026.
//

import Foundation

@MainActor
final class TickerSocketViewModel: ObservableObject {
    
    @Published var symbol = ""
    @Published var price = ""
    
    private let socket = BinanceSocket()
    
    init() {
        socket.onReceiveTicker = { ticker in
            self.symbol = ticker.symbol
            self.price = ticker.closePrice
        }
    }
    
    func connect(symbol: String) {
        socket.connect(symbol: symbol)
    }
    
    func disconnect() {
        socket.disconnect()
    }
}
