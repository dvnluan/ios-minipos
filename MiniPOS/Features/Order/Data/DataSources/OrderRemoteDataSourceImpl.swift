import Foundation

class OrderRemoteDataSourceImpl: OrderRemoteDataSourceProtocol {
    
    func createOrder(tableNumber: Int, items: [[String: Any]]) async throws -> BaseResponse {
        let body: [String: Any] = [
            "table_number": tableNumber,
            "items": items
        ]
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        return try await NetworkService.shared.request(endpoint: "/orders", method: "POST", body: bodyData)
    }
    
    func getOrders() async throws -> [Order] {
        return try await NetworkService.shared.request(endpoint: "/orders")
    }
    
    func getOrderDetails(id: Int) async throws -> Order {
        return try await NetworkService.shared.request(endpoint: "/orders/\(id)")
    }
    
    func payOrder(id: Int) async throws -> BaseResponse {
        return try await NetworkService.shared.request(endpoint: "/orders/\(id)/pay", method: "POST")
    }
}
