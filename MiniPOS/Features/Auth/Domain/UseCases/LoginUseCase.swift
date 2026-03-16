import Foundation

class LoginUseCase {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(username: String, password: String) async throws -> AuthResponse {
        return try await repository.login(username: username, password: password)
    }
}
