import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Image(systemName: "bag.fill.badge.plus")
                        .font(.system(size: 80))
                        .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                    Text("Mini POS")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Đăng nhập để tiếp tục")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 50)
                
                VStack(spacing: 15) {
                    TextField("Tên đăng nhập", text: $viewModel.username)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
 
                    SecureField("Mật khẩu", text: $viewModel.password)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
  
                }
                .padding(.horizontal)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    Task {
                        await viewModel.login()
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Đăng nhập")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isLoading ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Text("Một sản phẩm của")
                        .foregroundStyle(.secondary)
                    Text("LUTech")
                        .foregroundStyle(.secondary)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
