import Foundation

struct OrderItem: Codable, Identifiable, Hashable {
    let id: Int
    let quantity: Int
    let priceAtTime: String
    let product: SimpleProduct

    enum CodingKeys: String, CodingKey {
        case id
        case quantity
        case priceAtTime = "price_at_time"
        case product
    }
}
