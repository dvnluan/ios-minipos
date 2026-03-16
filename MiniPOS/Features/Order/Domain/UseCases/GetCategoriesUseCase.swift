import Foundation

class GetCategoriesUseCase {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Category] {
        try await repository.getCategories()
    }
}
