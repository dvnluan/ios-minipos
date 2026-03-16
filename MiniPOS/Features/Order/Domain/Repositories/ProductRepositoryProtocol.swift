import Foundation

protocol ProductRepositoryProtocol {
    func getProducts() async throws -> [Product]
    func getCategories() async throws -> [Category]
}
