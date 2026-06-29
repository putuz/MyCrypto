import Foundation

final class OrderBookSnapshotViewModel: ObservableObject {
    
    @Published var bids: [(Double, Double)] = []
    @Published var asks: [(Double, Double)] = []
    @Published var lastUpdateId: Int64 = 0
    
    private let service = OrderBookSnapshotService()
    
    func load(symbol: String) async {
        do {
            let data = try await service.fetch(symbol: symbol)
            
            let bids = data.bids.compactMap { parse($0) }
                .sorted { $0.0 > $1.0 }
            
            let asks = data.asks.compactMap { parse($0) }
                .sorted { $0.0 < $1.0 }
            
            await MainActor.run {
                self.bids = bids
                self.asks = asks
                self.lastUpdateId = data.lastUpdateId
            }
            
        } catch {
            print("Snapshot error:", error)
        }
    }
    
    private func parse(_ item: [String]) -> (Double, Double)? {
        guard item.count >= 2,
              let price = Double(item[0]),
              let qty = Double(item[1]) else {
            return nil
        }
        return (price, qty)
    }
}