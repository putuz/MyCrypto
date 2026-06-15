//
//  KlineServiceProtocol.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import Foundation

protocol KlineServiceProtocol {
    func connect(symbol: String, interval: String)
    
    func disconnect()
}
