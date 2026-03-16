import SwiftUI

struct OrderDetailView: View {
    @EnvironmentObject var router: PaymentRouter
    let onPaid: () -> Void
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: OrderDetailViewModel
    
    init(order: Order, onPaid: @escaping () -> Void) {
        self.onPaid = onPaid
        self._viewModel = StateObject(wrappedValue: OrderDetailViewModel(order: order))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    Section(header: Text("Thông tin bàn")) {
                        HStack {
                            Text("Bàn")
                            Spacer()
                            Text("\(viewModel.order.tableNumber)")
                                .fontWeight(.bold)
                        }
                        
                        HStack {
                            Text("Giờ vào")
                            Spacer()
                            Text(viewModel.order.createdAt)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Section(header: Text("Chi tiết món ăn")) {
                        if viewModel.orderItems.isEmpty {
                            Text("Không có thông tin món ăn")
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(viewModel.orderItems) { item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(item.product.name)")
                                            .fontWeight(.medium)
                                        Text("\(item.priceAtTime.toCurrency()) x \(item.quantity)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(((Double(item.priceAtTime) ?? 0) * Double(item.quantity)).toCurrency())
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("Tổng cộng")
                                .font(.headline)
                            Spacer()
                            Text(viewModel.order.totalAmount.toCurrency())
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    let success = await viewModel.processPayment()
                    if success {
                        onPaid()
                        router.pop()
                    }
                }
            }) {
                if viewModel.isProcessing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Xác nhận thanh toán")
                        .fontWeight(.bold)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(viewModel.isProcessing ? Color.gray : Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding()
            .disabled(viewModel.isProcessing)
        }
        .navigationTitle("Chi tiết đơn hàng")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task { await viewModel.fetchOrderDetail() }
        }
    }
}

#Preview {
    NavigationView {
        OrderDetailView(order: Order.mockPending, onPaid: {})
    }
}
