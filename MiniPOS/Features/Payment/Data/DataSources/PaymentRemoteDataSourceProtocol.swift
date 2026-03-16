import Foundation

protocol PaymentRemoteDataSourceProtocol {
    func getAllOrders() async throws -> [Order]
    func getPendingOrders() async throws -> [Order]
    func getOrderDetails(id: Int) async throws -> Order
    func payOrder(id: Int) async throws -> BaseResponse
}

