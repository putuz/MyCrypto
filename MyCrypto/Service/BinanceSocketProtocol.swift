//
//  BinanceSocketProtocol.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 13/06/2026.
//

import Foundation

protocol BinanceSocketProtocol {
    func connect(symbol: String)
    
    func disconnect()
}
