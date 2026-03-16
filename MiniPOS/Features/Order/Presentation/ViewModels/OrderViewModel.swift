import SwiftUI
import Combine

class OrderViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var categories: [Category] = []
    @Published var selectedCategoryId: Int?
    @Published var selectedTable: Int?
    @Published var cart: [Int: Int] = [:] // productId: quantity
    @Published var isLoading = false
    @Published var showCart = false
    @Published var isSubmitting = false
    @Published var isOrderCreated = false
    @Published var alertMessage: String?
    @Published var showAlert = false
    
    private let getProductsUseCase: GetProductsUseCase
    private let getCategoriesUseCase: GetCategoriesUseCase
    private let createOrderUseCase: CreateOrderUseCase
    
    init(
        getProductsUseCase: GetProductsUseCase = GetProductsUseCase(repository: ProductRepositoryImpl()),
        getCategoriesUseCase: GetCategoriesUseCase = GetCategoriesUseCase(repository: ProductRepositoryImpl()),
        createOrderUseCase: CreateOrderUseCase = CreateOrderUseCase(repository: OrderRepositoryImpl())
    ) {
        self.getProductsUseCase = getProductsUseCase
        self.getCategoriesUseCase = getCategoriesUseCase
        self.createOrderUseCase = createOrderUseCase
    }
    
    var filteredProducts: [Product] {
        if let categoryId = selectedCategoryId {
            return products.filter { $0.categoryId == categoryId }
        }
        return products
    }
    
    var totalQuantity: Int {
        cart.values.reduce(0, +)
    }
    
    var totalAmount: Double {
        cart.reduce(0.0) { result, item in
            let product = products.first(where: { $0.id == item.key })
            let price = Double(product?.price ?? "0") ?? 0
            return result + price * Double(item.value)
        }
    }
    
    @MainActor
    func fetchData() async {
        isLoading = true
        
        do {
            async let productsRes = getProductsUseCase.execute()
            async let categoriesRes = getCategoriesUseCase.execute()
            
            let (fetchedProducts, fetchedCategories) = try await (productsRes, categoriesRes)
            
            self.products = fetchedProducts
            self.categories = fetchedCategories
            self.isLoading = false
        } catch {
            print("Fetch data error: \(error)")
            self.isLoading = false
        }
    }
    
    @MainActor
    func addToCart(product: Product) {
        cart[product.id, default: 0] += 1
    }
    
    @MainActor
    func removeFromCart(product: Product) {
        guard let current = cart[product.id], current > 0 else { return }
        if current == 1 {
            cart.removeValue(forKey: product.id)
        } else {
            cart[product.id] = current - 1
        }
    }
    
    @MainActor
    func submitOrder() async {
        guard let table = selectedTable, !cart.isEmpty else {
            return
        }
        
        isSubmitting = true
        
        let items = cart.map { ["product_id": $0.key, "quantity": $0.value] }
        
        do {
            let response = try await createOrderUseCase.execute(tableNumber: table, items: items)
            
            if response.success {
                self.cart = [:]
                self.selectedTable = nil
                self.alertMessage = "Đặt món thành công!"
                isSubmitting = false
                isOrderCreated = true
            } else {
                self.alertMessage = response.message ?? "Lỗi đặt món"
                isSubmitting = false
            }
        } catch {
            self.alertMessage = "Lỗi kết nối: \(error.localizedDescription)"
            isSubmitting = false
        }
        
        showAlert = true
    }
}
