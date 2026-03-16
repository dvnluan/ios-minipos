import Foundation

class PayOrderUseCase {
    private let repository: PaymentRepositoryProtocol

    init(repository: PaymentRepositoryProtocol = PaymentRepositoryImpl()) { 
        self.repository = repository 
    }
    
    func execute(id: Int) async throws -> BaseResponse {
        try await repository.payOrder(id: id)
    }
}
