//
//  OrderBookViewModel.swift
//  MyCrypto
//
//  Created by Bahtiar on 29/06/26.
//

import Foundation

final class OrderBookViewModel: ObservableObject {
    
    @Published var bids: [(price: Double, qty: Double)] = []
    @Published var asks: [(price: Double, qty: Double)] = []
    
    private let service = OrderBookSocketService()
    
    func connect(symbol: String) {
        service.onMessage = { text in
            
        }
        
        service.connect(symbol: symbol)
    }
    
    func disconnect() {
        service.disconnect()
    }
    
    private func handleMessage(_ text: String) {
        guard let data = text.data(using: .utf8) else { return }
        
        do {
            let decoded = try JSONDecoder().decode(OrderBookResponse.self, from: data)
            
            let bids = decoded.b.compactMap { item -> (Double, Double)? in
                guard let price = Double(item[0]), let qty = Double(item[1]) else { return nil }
                return (price, qty)
            }
            
            let asks = decoded.a.compactMap { item -> (Double, Double)? in
                guard let price = Double(item[0]), let qty = Double(item[1]) else { return nil }
                return (price, qty)
            }
            
            DispatchQueue.main.async {
                self.bids = bids
                self.asks = asks
            }
        } catch {
            print("Decode error:", error)
        }
    }
}
