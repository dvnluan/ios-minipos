import Foundation

struct AuthResponse: Codable {
    let success: Bool
    let userId: Int?
    let token: String?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case success, token, message
        case userId = "user_id"
    }
}
