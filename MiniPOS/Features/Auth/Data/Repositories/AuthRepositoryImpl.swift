import Foundation

class AuthRepositoryImpl: AuthRepositoryProtocol {
    private let remoteDataSource: AuthRemoteDataSourceProtocol
    
    init(remoteDataSource: AuthRemoteDataSourceProtocol = AuthRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func login(username: String, password: String) async throws -> AuthResponse {
        return try await remoteDataSource.login(username: username, password: password)
    }
}
