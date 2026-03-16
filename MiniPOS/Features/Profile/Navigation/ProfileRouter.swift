import SwiftUI
import Combine

enum ProfileDestination: Hashable {
    // Thêm các màn hình trong luồng Profile nếu có
}

class ProfileRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to destination: ProfileDestination) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
