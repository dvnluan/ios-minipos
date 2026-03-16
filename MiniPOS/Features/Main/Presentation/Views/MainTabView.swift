import SwiftUI

struct MainTabView: View {
    @StateObject private var authManager = AuthManager.shared
    @StateObject private var orderRouter = OrderRouter()
    @StateObject private var paymentRouter = PaymentRouter()
    @StateObject private var profileRouter = ProfileRouter()
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $orderRouter.path) {
                OrderView()
                    .navigationDestination(for: OrderDestination.self) { destination in
                        // Handle order destinations
                    }
            }
            .environmentObject(orderRouter)
            .tabItem {
                Label("Tạo đơn", systemImage: "plus.circle.fill")
            }
            .tag(0)
            
            NavigationStack(path: $paymentRouter.path) {
                PaymentListView()
                    .navigationDestination(for: PaymentDestination.self) { destination in
                        switch destination {
                        case .orderDetail(let order):
                            OrderDetailView(order: order, onPaid: {
                                // TODO
                            })
                        }
                    }
            }
            .environmentObject(paymentRouter)
            .tabItem {
                Label("Thanh toán", systemImage: "creditcard.fill")
            }
            .tag(1)
            
            NavigationStack(path: $profileRouter.path) {
                ProfileView()
                    .navigationDestination(for: ProfileDestination.self) { destination in
                        // Handle profile destinations
                    }
            }
            .environmentObject(profileRouter)
            .tabItem {
                Label("Nhân viên", systemImage: "person.fill")
            }
            .tag(2)
        }
        .accentColor(.blue)
    }
}

#Preview {
    MainTabView()
}
