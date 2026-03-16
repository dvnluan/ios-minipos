import Foundation

#if DEBUG
extension Category {
    static let mockFood = Category(id: 1, name: "Đồ ăn")
    static let mockDrink = Category(id: 2, name: "Đồ uống")
    
    static let mockList = [mockFood, mockDrink]
}
#endif
