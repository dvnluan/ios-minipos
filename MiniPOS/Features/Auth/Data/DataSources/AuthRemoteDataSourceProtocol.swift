import Foundation

protocol AuthRemoteDataSourceProtocol {
    func login(username: String, password: String) async throws -> AuthResponse
}

