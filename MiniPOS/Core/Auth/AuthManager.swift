import Foundation
import Combine
import KeychainSwift

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var token: String?
    @Published var userId: Int?
    
    private let keychain = KeychainSwift()
    private let tokenKey = "jwt_token"
    private let userIdKey = "user_id"
    
    private init() {
        self.token = keychain.get(tokenKey)
        if let userIdString = keychain.get(userIdKey) {
            self.userId = Int(userIdString)
        }
        self.isLoggedIn = self.token != nil
    }
    
    func saveAuth(token: String, userId: Int) {
        self.token = token
        self.userId = userId
        self.isLoggedIn = true
        
        keychain.set(token, forKey: tokenKey)
        keychain.set(String(userId), forKey: userIdKey)
        
        // Clear legacy UserDefaults if they exist
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: userIdKey)
    }
    
    func logout() {
        self.token = nil
        self.userId = nil
        self.isLoggedIn = false
        
        keychain.delete(tokenKey)
        keychain.delete(userIdKey)
    }
}
