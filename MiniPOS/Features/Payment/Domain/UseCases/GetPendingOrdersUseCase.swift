import Foundation

class GetPendingOrdersUseCase {
    private let repository: PaymentRepositoryProtocol
    init(repository: PaymentRepositoryProtocol = PaymentRepositoryImpl()) { self.repository = repository }
    
    func execute() async throws -> [Order] {
        try await repository.getPendingOrders()
    }
}
