import Foundation

class ProductRepositoryImpl: ProductRepositoryProtocol {
    private let remoteDataSource: ProductRemoteDataSourceProtocol
    private let cache: ProductCacheActor
    
    init(
        remoteDataSource: ProductRemoteDataSourceProtocol = ProductRemoteDataSourceImpl(),
        cache: ProductCacheActor = .shared
    ) {
        self.remoteDataSource = remoteDataSource
        self.cache = cache
    }
    
    func getProducts() async throws -> [Product] {
        if let cached = await cache.getProducts() {
            return cached
        }
        let products = try await remoteDataSource.fetchProducts()
        await cache.setProducts(products)
        return products
    }
    
    func getCategories() async throws -> [Category] {
        if let cached = await cache.getCategories() {
            return cached
        }
        let categories = try await remoteDataSource.fetchCategories()
        await cache.setCategories(categories)
        return categories
    }
}
