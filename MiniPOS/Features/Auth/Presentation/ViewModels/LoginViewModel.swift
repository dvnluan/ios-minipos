import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let loginUseCase: LoginUseCase
    
    init(loginUseCase: LoginUseCase = LoginUseCase(repository: AuthRepositoryImpl())) {
        self.loginUseCase = loginUseCase
    }
    
    @MainActor
    func login() async {
        guard !username.isEmpty && !password.isEmpty else {
            errorMessage = "Vui lòng nhập đầy đủ thông tin"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await loginUseCase.execute(username: username, password: password)
            if response.success, let token = response.token, let userId = response.userId {
                AuthManager.shared.saveAuth(token: token, userId: userId)
            } else {
                errorMessage = response.message ?? "Đăng nhập thất bại"
            }
            isLoading = false
        } catch {
            errorMessage = "Lỗi kết nối: \(error.localizedDescription)"
            isLoading = false
        }
    }
}


