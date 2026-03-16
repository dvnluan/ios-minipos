import SwiftUI
import Combine

enum PaymentDestination: Hashable {
    case orderDetail(Order)
}

class PaymentRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to destination: PaymentDestination) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
