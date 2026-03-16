import SwiftUI
import Combine

enum OrderDestination: Hashable {
    // Thêm các màn hình trong luồng Order nếu có
}

class OrderRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to destination: OrderDestination) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
