import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let username: String
    let fullName: String?
    let role: String?
    
    enum CodingKeys: String, CodingKey {
        case id, username, role
        case fullName = "full_name"
    }
}
