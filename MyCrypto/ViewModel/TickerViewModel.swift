//
//  TickerViewModel.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 10/06/2026.
//

import Foundation

@MainActor
final class TickerViewModel: ObservableObject {
    @Published var symbol = ""
    @Published var price = ""
    
    private let service: BinanceServiceProtocol
    
    init(service: BinanceServiceProtocol = BinanceService()){
        self.service = service
    }
    
    func load(symbol: String) async {
        do {
            let response = try await service.fetchTicker(symbol: symbol)
            self.symbol = response.symbol
            self.price = response.price
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
