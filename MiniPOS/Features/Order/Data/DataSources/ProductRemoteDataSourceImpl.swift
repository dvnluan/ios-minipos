import Foundation

class ProductRemoteDataSourceImpl: ProductRemoteDataSourceProtocol {
    
    func fetchProducts() async throws -> [Product] {
        return try await NetworkService.shared.request(endpoint: "/products")
    }
    
    func fetchCategories() async throws -> [Category] {
        return try await NetworkService.shared.request(endpoint: "/categories")
    }
}
