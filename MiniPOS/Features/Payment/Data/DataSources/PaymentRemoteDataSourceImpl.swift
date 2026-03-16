import Foundation

class PaymentRemoteDataSourceImpl: PaymentRemoteDataSourceProtocol {
    
    func getAllOrders() async throws -> [Order] {
        return try await NetworkService.shared.request(endpoint: "/orders")
    }
    
    func getPendingOrders() async throws -> [Order] {
        return try await NetworkService.shared.request(endpoint: "/orders/pending")
    }
    
    func getOrderDetails(id: Int) async throws -> Order {
        return try await NetworkService.shared.request(endpoint: "/orders/\(id)")
    }
    
    func payOrder(id: Int) async throws -> BaseResponse {
        return try await NetworkService.shared.request(endpoint: "/orders/\(id)/pay", method: "POST")
    }
}
