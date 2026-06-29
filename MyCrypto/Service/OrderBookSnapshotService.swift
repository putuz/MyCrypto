import Foundation

final class OrderBookSnapshotService {
    
    func fetch(symbol: String) async throws -> OrderBookSnapshotResponse {
        
        let urlString = "https://api.binance.com/api/v3/depth?symbol=\(symbol.uppercased())&limit=100"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(OrderBookSnapshotResponse.self, from: data)
        
        return decoded
    }
}