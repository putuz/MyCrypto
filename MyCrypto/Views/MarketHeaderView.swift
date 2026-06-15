//
//  MarketHeaderView.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 12/06/2026.
//

import SwiftUI

struct MarketHeaderView: View {
    let count: Int
    
    var body: some View {
        HStack {
            Text("Markets")
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("\(count)")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    MarketHeaderView(count: 2543)
}
