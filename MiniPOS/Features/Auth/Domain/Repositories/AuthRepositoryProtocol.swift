import Foundation

protocol AuthRepositoryProtocol {
    func login(username: String, password: String) async throws -> AuthResponse
}
