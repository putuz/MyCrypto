//
//  CandleSectionView.swift
//  MyCrypto
//
//  Created by Amelia Putri Oktaviani on 12/06/2026.
//

import SwiftUI
import Charts

struct CandleSectionView: View {
    
    let symbol: String
    let interval: String
    let candles: [Candle]
    @State private var scrollPosition = 0
    
    private var lastClose: Double {
        candles.last?.close ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(symbol)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(interval)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(.orange.opacity(0.15))
                    .clipShape(Capsule())
            }
            
            // MARK: Chart
            Chart {
                ForEach(
                    Array(candles.enumerated()),
                    id: \.element.id
                ) { index, candle in

                    RuleMark(
                        x: .value("Index", index),
                        yStart: .value("Low", candle.low),
                        yEnd: .value("High", candle.high)
                    )
                    .foregroundStyle(candle.isBullish ? .green : .red)

                    RectangleMark(
                        x: .value("Index", index),
                        yStart: .value("OpenCloseMin", min(candle.open, candle.close)),
                        yEnd: .value("OpenCloseMax", max(candle.open, candle.close)),
                        width: 5
                    )
                    .foregroundStyle(candle.isBullish ? .green : .red)
                }
                
                // MARK: Realtime price line
                RuleMark(y: .value("Last Price", lastClose))
                    .foregroundStyle(.orange.opacity(0.8))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                    .annotation(
                        position: .overlay,
                        alignment: .trailing
                    ) {
                        Text(lastClose.formatted(.number.precision(.fractionLength(2))))
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
            }
            .frame(height: 320)
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 50)
            .chartScrollPosition(x: $scrollPosition)
            .chartYScale(domain: minPrice...maxPrice)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartLegend(.hidden)
            .chartXAxis(.hidden)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            scrollPosition = max(candles.count - 50, 0)
        }
        .onChange(of: candles.count) { _, _ in
            scrollPosition = max(candles.count - 50, 0)
        }
    }
    
    private var minPrice: Double {
        guard let min = candles.map(\.low).min() else { return 0 }
        return min * 0.998
    }
    
    private var maxPrice: Double {
        guard let max = candles.map(\.high).max() else { return 0 }
        return max * 1.002
    }
}

#Preview {
    CandleSectionView(symbol: "BTCUSDT", interval: "15m", candles: Candle.previewData)
}
