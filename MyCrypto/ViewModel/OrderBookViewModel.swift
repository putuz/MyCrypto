@MainActor
final class OrderBookViewModel: ObservableObject {

    @Published var bids: [(price: Double, qty: Double)] = []
    @Published var asks: [(price: Double, qty: Double)] = []

    // MARK: Services

    private let snapshotService = OrderBookSnapshotService()
    private let socketService = OrderBookSocketService()

    // MARK: Local Order Book

    private var bidBook: [Double: Double] = [:]
    private var askBook: [Double: Double] = [:]

    // MARK: Binance Sync

    private var lastUpdateId: Int64 = 0
    private var isSnapshotLoaded = false

    // Buffer websocket event sebelum snapshot selesai
    private var pendingEvents: [OrderBookResponse] = []

    // MARK: Public

    func connect(symbol: String) {

        disconnect()

        isSnapshotLoaded = false
        pendingEvents.removeAll()

        socketService.onMessage = { [weak self] text in
            self?.handleSocket(text)
        }

        socketService.onError = { error in
            print(error)
        }

        socketService.connect(symbol: symbol)

        Task {
            await loadSnapshot(symbol: symbol)
        }
    }

    func disconnect() {

        socketService.disconnect()

        bidBook.removeAll()
        askBook.removeAll()

        bids.removeAll()
        asks.removeAll()

        pendingEvents.removeAll()

        lastUpdateId = 0
        isSnapshotLoaded = false
    }
}

// MARK: Snapshot

private extension OrderBookViewModel {

    func loadSnapshot(symbol: String) async {

        do {

            let snapshot = try await snapshotService.fetch(symbol: symbol)

            bidBook.removeAll()
            askBook.removeAll()

            snapshot.bids.forEach { item in

                guard item.count >= 2,
                      let price = Double(item[0]),
                      let qty = Double(item[1]) else {
                    return
                }

                bidBook[price] = qty
            }

            snapshot.asks.forEach { item in

                guard item.count >= 2,
                      let price = Double(item[0]),
                      let qty = Double(item[1]) else {
                    return
                }

                askBook[price] = qty
            }

            lastUpdateId = snapshot.lastUpdateId
            isSnapshotLoaded = true

            // Apply semua event yang sudah diterima
            pendingEvents.forEach {
                apply(event: $0)
            }

            pendingEvents.removeAll()

            publish()

        } catch {

            print(error)
        }
    }
}

// MARK: Socket

private extension OrderBookViewModel {

    func handleSocket(_ text: String) {

        guard let data = text.data(using: .utf8) else {
            return
        }

        do {

            let event = try JSONDecoder().decode(OrderBookResponse.self, from: data)

            if !isSnapshotLoaded {

                pendingEvents.append(event)
                return
            }

            apply(event: event)

        } catch {

            print(error)
        }
    }
}

// MARK: Merge

private extension OrderBookViewModel {

    func apply(event: OrderBookResponse) {

        // Ignore event lama

        if event.u <= lastUpdateId {
            return
        }

        lastUpdateId = event.u

        // Update bids

        event.b.forEach {

            guard
                $0.count >= 2,
                let price = Double($0[0]),
                let qty = Double($0[1])
            else {
                return
            }

            if qty == 0 {

                bidBook.removeValue(forKey: price)

            } else {

                bidBook[price] = qty
            }
        }

        // Update asks

        event.a.forEach {

            guard
                $0.count >= 2,
                let price = Double($0[0]),
                let qty = Double($0[1])
            else {
                return
            }

            if qty == 0 {

                askBook.removeValue(forKey: price)

            } else {

                askBook[price] = qty
            }
        }

        publish()
    }
}

// MARK: Publish

private extension OrderBookViewModel {

    func publish() {

        bids = bidBook
            .sorted { $0.key > $1.key }
            .map { ($0.key, $0.value) }

        asks = askBook
            .sorted { $0.key < $1.key }
            .map { ($0.key, $0.value) }
    }
}