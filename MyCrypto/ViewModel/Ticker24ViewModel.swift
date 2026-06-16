//
//  Ticker24ViewModel.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 11/06/2026.
//

import Foundation

@MainActor
final class Ticker24ViewModel: ObservableObject {
    @Published var ticker24: [Ticker24] = []
    @Published var searchText = ""
    
    private let service: BinanceServiceProtocol
    
    init(service: BinanceServiceProtocol = BinanceService()) {
        self.service = service
    }
    
    var filteredTickers: [Ticker24] {
        guard !searchText.isEmpty else { return ticker24 }
        
        return ticker24.filter { $0.symbol.lowercased().contains(searchText.lowercased())}
    }
    
    func load() async {
        do {
            let response = try await service.fetchTicker24()
            print("Count:", response.count)
            ticker24 = response
        } catch {
            print(error.localizedDescription)
        }
    }
}
