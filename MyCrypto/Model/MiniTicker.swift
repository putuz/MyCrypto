//
//  MiniTicker.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 13/06/2026.
//

import Foundation

struct MiniTicker: Decodable {
    let eventType: String
    let eventTime: Int64
    
    let symbol: String
    
    let closePrice: String
    let openPrice: String
    let highPrice: String
    let lowPrice: String
    
    let volume: String
    let quoteVolume: String
    
    enum CodingKeys: String, CodingKey {
        case eventType = "e"
        case eventTime = "E"
        
        case symbol = "s"
        
        case closePrice = "c"
        case openPrice = "o"
        case highPrice = "h"
        case lowPrice = "l"
        
        case volume = "v"
        case quoteVolume = "q"
    }
}
