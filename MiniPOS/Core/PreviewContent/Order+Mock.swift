import Foundation

#if DEBUG
extension Order {
    static let mockPending = Order(
        id: 1, 
        tableNumber: 5, 
        totalAmount: "120000.00", 
        status: "pending", 
        createdAt: "2024-03-12 10:30",
        paidAt: nil,
        userId: 1,
        userName: nil,
        items: [OrderItem.mock1, OrderItem.mock2]
    )
    
    static let mockCompleted = Order(
        id: 2, 
        tableNumber: 8, 
        totalAmount: "250000.00", 
        status: "completed", 
        createdAt: "2024-03-12 11:15",
        paidAt: nil,
        userId: 1,
        userName: nil,
        items: [OrderItem.mock1, OrderItem.mock2]
    )
    
    static let mockList = [mockPending, mockCompleted]
}
#endif
