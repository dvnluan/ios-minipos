import Foundation

#if DEBUG
extension OrderItem {
    static let mock1 = OrderItem(
        id: 1,
        quantity: 2,
        priceAtTime: "50000",
        product: SimpleProduct(
            id: 1,
            name: "Phở tái"
        )
    )
    static let mock2 = OrderItem(
        id: 2,
        quantity: 2,
        priceAtTime: "40000",
        product: SimpleProduct(
            id: 2,
            name: "Phở chín"
        )
    )
}
#endif
