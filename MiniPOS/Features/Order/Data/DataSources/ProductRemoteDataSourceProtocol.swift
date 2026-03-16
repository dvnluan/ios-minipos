import Foundation

protocol ProductRemoteDataSourceProtocol {
    func fetchProducts() async throws -> [Product]
    func fetchCategories() async throws -> [Category]
}


