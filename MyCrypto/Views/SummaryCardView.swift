//
//  SummaryCardView.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 12/06/2026.
//

import SwiftUI

struct SummaryCardView: View {
    
    let serverTime: String
    let symbol: String
    let price: String
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text(symbol)
                        .font(.headline)
                    
                    Text("$\(price)")
                        .font(.system(size: 34, weight: .bold))
                        .monospacedDigit()
                }
                
                Spacer()
                Image(systemName: "bitcoinsign.circle.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.orange)
            }
            
            Divider()
            
            HStack {
                Label("Server Time", systemImage: "clock.fill")
                
                Spacer()
                
                Text(serverTime)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    .orange.opacity(0.25),
                    .yellow.opacity(0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    SummaryCardView(
            serverTime: "1781097235432",
            symbol: "BTCUSDT",
            price: "105432.12"
        )
        .padding()
}
