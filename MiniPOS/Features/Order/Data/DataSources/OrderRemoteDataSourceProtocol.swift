import Foundation

protocol OrderRemoteDataSourceProtocol {
    func createOrder(tableNumber: Int, items: [[String: Any]]) async throws -> BaseResponse
    func getOrders() async throws -> [Order]
    func getOrderDetails(id: Int) async throws -> Order
    func payOrder(id: Int) async throws -> BaseResponse
}

