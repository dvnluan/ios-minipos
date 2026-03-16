import Foundation

class ProductRepositoryImpl: ProductRepositoryProtocol {
    private let remoteDataSource: ProductRemoteDataSourceProtocol
    
    init(remoteDataSource: ProductRemoteDataSourceProtocol = ProductRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getProducts() async throws -> [Product] {
        return try await remoteDataSource.fetchProducts()
    }
    
    func getCategories() async throws -> [Category] {
        return try await remoteDataSource.fetchCategories()
    }
}
