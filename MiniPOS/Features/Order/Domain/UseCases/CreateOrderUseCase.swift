import Foundation

class CreateOrderUseCase {
    private let repository: OrderRepositoryProtocol
    
    init(repository: OrderRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(tableNumber: Int, items: [[String: Any]]) async throws -> BaseResponse {
        try await repository.createOrder(tableNumber: tableNumber, items: items)
    }
}
