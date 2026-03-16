import Foundation

struct BaseResponse: Codable {
    let success: Bool
    let message: String?
    let id: Int?
}
