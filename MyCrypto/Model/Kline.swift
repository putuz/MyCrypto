//
//  Kline.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 15/06/2026.
//

import Foundation

struct KlineEvent: Decodable {
    let kline: Kline
    
    enum CodingKeys: String, CodingKey {
        case kline = "k"
    }
}

struct Kline: Decodable {
    let openTime: Int64
    
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
    
    let isClosed: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case openTime = "t"
        
        case open = "o"
        case high = "h"
        case low = "l"
        case close = "c"
        case volume = "v"
        
        
        case isClosed = "x"
    }
}
