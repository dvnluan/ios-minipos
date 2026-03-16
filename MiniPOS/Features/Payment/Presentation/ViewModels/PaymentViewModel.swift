import Foundation
import Combine

class PaymentViewModel: ObservableObject {
    
    @Published var orders: [Order] = []
    @Published var isLoading = false
    
    private let getPendingOrdersUseCase: GetPendingOrdersUseCase
    
    init(getPendingOrdersUseCase: GetPendingOrdersUseCase = GetPendingOrdersUseCase(repository: PaymentRepositoryImpl())) {
        self.getPendingOrdersUseCase = getPendingOrdersUseCase
    }
    
    @MainActor
    func fetchPedingOrders() async {
        isLoading = true
        
        do {
            let fetchedOrders = try await getPendingOrdersUseCase.execute()
            self.orders = fetchedOrders
            self.isLoading = false
        } catch {
            print("Fetch pending orders error: \(error)")
            self.isLoading = false
        }
    }
}
