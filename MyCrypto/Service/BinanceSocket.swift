//
//  BinanceSocket.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 13/06/2026.
//

import Foundation

final class BinanceSocket: BinanceSocketProtocol {
    private var socketTask: URLSessionWebSocketTask?
    private var currentSymbol = ""
    
    var onReceiveTicker: ((MiniTicker) -> Void)?
    
    func connect(symbol: String) {
        guard symbol != currentSymbol else { return }
        
        currentSymbol = symbol
        
        disconnect()
        
        let url = URL(string: "wss://stream.binance.com:9443/ws/\(symbol.lowercased())@miniTicker")!
        
        socketTask = URLSession.shared.webSocketTask(with: url)
        
        socketTask?.resume()
        
        receive()
    }
    
    func disconnect() {
        socketTask?.cancel(with: .goingAway, reason: nil)
        socketTask = nil
    }
    
    private func receive() {
        socketTask?.receive { result in
            switch result {
            case.success(let message):
                switch message {
                case .string(let text):
                    guard let data = text.data(using: .utf8) else { return }
                    do {
                        let ticker = try JSONDecoder().decode(MiniTicker.self, from: data)
                        DispatchQueue.main.async {
                            self.onReceiveTicker?(ticker)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                default:
                    break
                }
                
                self.receive()
                
            case .failure(let error):

                let nsError = error as NSError

                if nsError.domain == NSPOSIXErrorDomain,
                   nsError.code == 57 {
                    return
                }

                print("MINI TICKER ERROR")
                print(error)
            }
        }
    }
}
