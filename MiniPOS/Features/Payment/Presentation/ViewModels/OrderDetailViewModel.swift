import Foundation
import Combine

class OrderDetailViewModel: ObservableObject {
    
    @Published var order: Order
    @Published var orderItems: [OrderItem] = []
    @Published var isLoading = false
    @Published var isProcessing = false
    
    private let getOrderDetailUseCase: GetOrderDetailUseCase
    private let payOrderUseCase: PayOrderUseCase
    
    init(order: Order,
         getOrderDetailUseCase: GetOrderDetailUseCase = GetOrderDetailUseCase(),
         payOrderUseCase: PayOrderUseCase = PayOrderUseCase()) {
        self.order = order
        self.getOrderDetailUseCase = getOrderDetailUseCase
        self.payOrderUseCase = payOrderUseCase
    }
    
    @MainActor
    func fetchOrderDetail() async {
        isLoading = true
        do {
            let detailedOrder = try await getOrderDetailUseCase.execute(id: order.id)
            self.orderItems = detailedOrder.items ?? []
            self.isLoading = false
        } catch {
            print("Fetch order detail error: \(error)")
            self.isLoading = false
        }
    }
    
    @MainActor
    func processPayment() async -> Bool {
        isProcessing = true
        do {
            let response = try await payOrderUseCase.execute(id: order.id)
            isProcessing = false
            return response.success
        } catch {
            print("Payment error: \(error)")
            isProcessing = false
            return false
        }
    }
}
