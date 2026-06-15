//
//  TimeViewModel.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 10/06/2026.
//

import Foundation

@MainActor
final class TimeViewModel: ObservableObject {
    @Published var serverTime = ""
    
    private let service: BinanceServiceProtocol
    
    init(service: BinanceServiceProtocol = BinanceService()) {
        self.service = service
    }
    
    func load() async {
        do {
            let response = try await service.fetchServerTime()
            
            serverTime = "\(response.serverTime)"
        } catch {
            serverTime = error.localizedDescription
        }
    }
}
