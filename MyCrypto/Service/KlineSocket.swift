//
//  KlineSocket.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import Foundation

final class KlineSocket: KlineServiceProtocol {
    private var socketTask: URLSessionWebSocketTask?
    
    var onReceiveTicker: ((Kline) -> Void)?
    
    func connect(symbol: String, interval: String) {
        
        disconnect()
        
        let url = URL(string: "wss://stream.binance.com:9443/ws/\(symbol.lowercased())@kline_\(interval)")!
        
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
                        let event = try JSONDecoder().decode(KlineEvent.self, from: data)
                        DispatchQueue.main.async {
                            self.onReceiveTicker?(event.kline)
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
                
                if nsError.domain == NSPOSIXErrorDomain, nsError.code == 57 {
                    return
                }
                print("KLINE ERROR")
                print(error)
            }
        }
    }
}
