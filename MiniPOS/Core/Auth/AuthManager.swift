import Foundation
import Combine

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var token: String?
    @Published var userId: Int?
    
    private let tokenKey = "jwt_token"
    private let userIdKey = "user_id"
    
    private init() {
        self.token = UserDefaults.standard.string(forKey: tokenKey)
        self.userId = UserDefaults.standard.integer(forKey: userIdKey)
        self.isLoggedIn = self.token != nil
    }
    
    func saveAuth(token: String, userId: Int) {
        self.token = token
        self.userId = userId
        self.isLoggedIn = true
        
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(userId, forKey: userIdKey)
    }
    
    func logout() {
        self.token = nil
        self.userId = nil
        self.isLoggedIn = false
        
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: userIdKey)
    }
}
