import Foundation

struct Order: Codable, Identifiable, Hashable {
    let id: Int
    let tableNumber: Int
    let totalAmount: String
    let status: String
    let createdAt: String
    let paidAt: String?
    let userId: Int?
    let userName: String?
    let items: [OrderItem]?

    enum CodingKeys: String, CodingKey {
        case id
        case tableNumber = "table_number"
        case totalAmount = "total_amount"
        case status
        case createdAt = "created_at"
        case paidAt = "paid_at"
        case userId = "user_id"
        case userName = "user_name"
        case items
    }
}
