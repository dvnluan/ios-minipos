import Foundation

class GetProductsUseCase {
    private let repository: ProductRepositoryProtocol
    init(repository: ProductRepositoryProtocol) { self.repository = repository }
    func execute() async throws -> [Product] { try await repository.getProducts() }
}
