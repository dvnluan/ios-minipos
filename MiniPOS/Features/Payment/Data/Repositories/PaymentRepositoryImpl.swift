import Foundation

class PaymentRepositoryImpl: PaymentRepositoryProtocol {
    private let remoteDataSource: PaymentRemoteDataSourceProtocol
    
    init(remoteDataSource: PaymentRemoteDataSourceProtocol = PaymentRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getAllOrders() async throws -> [Order] {
        return try await remoteDataSource.getAllOrders()
    }
    
    func getPendingOrders() async throws -> [Order] {
        return try await remoteDataSource.getPendingOrders()
    }
    
    func getOrderDetails(id: Int) async throws -> Order {
        return try await remoteDataSource.getOrderDetails(id: id)
    }
    
    func payOrder(id: Int) async throws -> BaseResponse {
        return try await remoteDataSource.payOrder(id: id)
    }
}
