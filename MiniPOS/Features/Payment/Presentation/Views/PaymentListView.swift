import SwiftUI

struct PaymentListView: View {
    @EnvironmentObject var router: PaymentRouter
    @StateObject private var viewModel: PaymentViewModel
    
    init(viewModel: PaymentViewModel = PaymentViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Đang tải danh sách đơn...")
            } else if viewModel.orders.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "tray.and.arrow.down")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    Text("Không có đơn hàng nào đang chờ")
                        .foregroundColor(.secondary)
                    
                    Button("Tải lại") {
                        Task { await viewModel.fetchPedingOrders() }
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                List {
                    ForEach(viewModel.orders) { order in
                        Button(action: {
                            router.navigate(to: .orderDetail(order))
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Bàn \(order.tableNumber)")
                                        .font(.headline)
                                    
                                    Text(order.createdAt)
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 5) {
                                    Text(order.status == "pending" ? "Đang ăn" : "Đã thanh toán")
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(order.status == "pending" ? Color.orange.opacity(0.1) : Color.green.opacity(0.1))
                                        .foregroundColor(order.status == "pending" ? .orange : .green)
                                        .cornerRadius(5)
                                    
                                    Text(order.totalAmount.toCurrency())
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.vertical, 8)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .navigationTitle("Thanh toán")
        .onAppear {
            Task {
                await viewModel.fetchPedingOrders()
            }
        }
        .refreshable {
            await viewModel.fetchPedingOrders()
        }
    }
}

#Preview {
    let viewModel = PaymentViewModel()
    viewModel.orders = Order.mockList
    return PaymentListView(viewModel: viewModel)
}
