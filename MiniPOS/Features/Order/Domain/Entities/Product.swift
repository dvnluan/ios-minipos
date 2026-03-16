import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let name: String
    let price: String
    let imageUrl: String?
    let categoryId: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, price
        case imageUrl = "image_url"
        case categoryId = "category_id"
    }
}
