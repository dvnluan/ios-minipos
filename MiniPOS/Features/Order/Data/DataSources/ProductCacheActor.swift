import Foundation

actor ProductCacheActor {
    static let shared = ProductCacheActor()
    
    private var products: [Product] = []
    private var categories: [Category] = []
    private var lastUpdated: Date?
    
    // Cache expiration time (e.g., 5 minutes)
    private let cacheDuration: TimeInterval = 300
    
    private init() {}
    
    func getProducts() -> [Product]? {
        if isCacheValid() {
            return products
        }
        return nil
    }
    
    func getCategories() -> [Category]? {
        if isCacheValid() {
            return categories
        }
        return nil
    }
    
    func setProducts(_ products: [Product]) {
        self.products = products
        self.lastUpdated = Date()
    }
    
    func setCategories(_ categories: [Category]) {
        self.categories = categories
        self.lastUpdated = Date()
    }
    
    func clearCache() {
        products = []
        categories = []
        lastUpdated = nil
    }
    
    private func isCacheValid() -> Bool {
        guard let lastUpdated = lastUpdated else { return false }
        return Date().timeIntervalSince(lastUpdated) < cacheDuration
    }
}
