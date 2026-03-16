import Foundation

class GetOrderDetailUseCase {
    private let repository: PaymentRepositoryProtocol
    init(repository: PaymentRepositoryProtocol = PaymentRepositoryImpl()) { self.repository = repository }
    
    func execute(id: Int) async throws -> Order {
        try await repository.getOrderDetails(id: id)
    }
}
