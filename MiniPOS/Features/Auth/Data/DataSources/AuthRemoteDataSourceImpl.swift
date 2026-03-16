import Foundation

class AuthRemoteDataSourceImpl: AuthRemoteDataSourceProtocol {
    
    func login(username: String, password: String) async throws -> AuthResponse {
        let body: [String: String] = ["username": username, "password": password]
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        
        return try await NetworkService.shared.request(
            endpoint: "/auth/login",
            method: "POST",
            body: bodyData,
            requiresAuth: false
        )
    }
}
