import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if viewModel.cart.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "cart.badge.minus")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    Text("Giỏ hàng của bạn đang trống")
                        .foregroundColor(.secondary)
                }
                .padding()
            } else {
                List {
                    Section(header: Text("Bàn \(viewModel.selectedTable ?? 0)")) {
                        ForEach(viewModel.cart.sorted(by: { $0.key < $1.key }), id: \.key) { productId, quantity in
                            if let product = viewModel.products.first(where: { $0.id == productId }) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(product.name)
                                            .fontWeight(.semibold)
                                        Text(product.price.toCurrency())
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 15) {
                                        Button(action: { viewModel.removeFromCart(product: product) }) {
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(.red)
                                        }
                                        .buttonStyle(.borderless)
                                        
                                        Text("\(quantity)")
                                            .frame(width: 30)
                                        
                                        Button(action: { viewModel.addToCart(product: product) }) {
                                            Image(systemName: "plus.circle")
                                                .foregroundColor(.green)
                                        }
                                        .buttonStyle(.borderless)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("Tổng cộng")
                                .fontWeight(.bold)
                            Spacer()
                            Text(viewModel.totalAmount.toCurrency())
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    await viewModel.submitOrder()
                    if viewModel.isOrderCreated {
                        dismiss()
                    }
                }
            }) {
                if viewModel.isSubmitting {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Xác nhận & Gửi đơn")
                        .fontWeight(.bold)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(viewModel.cart.isEmpty || viewModel.isSubmitting ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding()
            .disabled(viewModel.cart.isEmpty || viewModel.isSubmitting)
        }
        .navigationTitle("Giỏ hàng")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Đóng") { dismiss() }
            }
        }
    }
}

#Preview {
    let viewModel = OrderViewModel()
    viewModel.products = Product.mockList
    viewModel.cart = [1: 2, 3: 1]
    viewModel.selectedTable = 5
    return CartView(viewModel: viewModel)
}
