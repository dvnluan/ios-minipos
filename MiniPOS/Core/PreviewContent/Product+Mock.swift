import Foundation

#if DEBUG
extension Product {
    static let mockPho = Product(id: 1, name: "Phở Bò Tái", price: "50000.00", imageUrl: nil, categoryId: 1)
    static let mockCom = Product(id: 2, name: "Phở Bò Chín", price: "40000.00", imageUrl: nil, categoryId: 1)
    static let mockTraDa = Product(id: 3, name: "Trà Đá", price: "5000.00", imageUrl: nil, categoryId: 2)
    
    static let mockList = [mockPho, mockCom, mockTraDa]
}
#endif
