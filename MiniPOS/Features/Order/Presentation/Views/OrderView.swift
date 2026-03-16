import SwiftUI

struct OrderView: View {
    @EnvironmentObject var router: OrderRouter
    @StateObject private var viewModel: OrderViewModel
    
    init(viewModel: OrderViewModel = OrderViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack {
            // Chọn bàn
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(1...10, id: \.self) { table in
                        TableButton(number: table, isSelected: viewModel.selectedTable == table) {
                            viewModel.selectedTable = table
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 8)
            
            // Danh mục món ăn
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    CategoryCapsule(name: "Tất cả", isSelected: viewModel.selectedCategoryId == nil) {
                        viewModel.selectedCategoryId = nil
                    }
                    
                    ForEach(viewModel.categories) { category in
                        CategoryCapsule(name: category.name, isSelected: viewModel.selectedCategoryId == category.id) {
                            viewModel.selectedCategoryId = category.id
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Danh sách món ăn
            if viewModel.isLoading {
                Spacer()
                ProgressView("Đang tải thực đơn...")
                Spacer()
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(viewModel.filteredProducts) { product in
                            ProductCard(product: product) {
                                viewModel.addToCart(product: product)
                            }
                        }
                    }
                    .padding()
                }
            }
            
            // Tóm tắt đơn hàng
            if !viewModel.cart.isEmpty {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(viewModel.totalQuantity) món")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(viewModel.totalAmount.toCurrency())
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.showCart = true
                        }) {
                            Text("Xem giỏ hàng")
                                .fontWeight(.bold)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(viewModel.selectedTable == nil ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        .disabled(viewModel.selectedTable == nil)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                    .padding()
                    
                    if viewModel.selectedTable == nil {
                        Text("Vui lòng chọn bàn trước khi chọn món")
                            .font(.caption2)
                            .foregroundColor(.red)
                            .padding(.bottom, 5)
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle("Tạo đơn")
        .sheet(isPresented: $viewModel.showCart, onDismiss: {
            
        }) {
            CartView(viewModel: viewModel)
        }
        .alert(viewModel.alertMessage ?? "", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    let viewModel = OrderViewModel()
    viewModel.products = Product.mockList
    viewModel.categories = Category.mockList
    return OrderView(viewModel: viewModel)
}
