import Foundation

class OrderRepositoryImpl: OrderRepositoryProtocol {
    private let remoteDataSource: OrderRemoteDataSourceProtocol
    
    init(remoteDataSource: OrderRemoteDataSourceProtocol = OrderRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func createOrder(tableNumber: Int, items: [[String: Any]]) async throws -> BaseResponse {
        return try await remoteDataSource.createOrder(tableNumber: tableNumber, items: items)
    }
    
    func getOrders() async throws -> [Order] {
        return try await remoteDataSource.getOrders()
    }
    
    func getOrderDetails(id: Int) async throws -> Order {
        return try await remoteDataSource.getOrderDetails(id: id)
    }
    
    func payOrder(id: Int) async throws -> BaseResponse {
        return try await remoteDataSource.payOrder(id: id)
    }
}
