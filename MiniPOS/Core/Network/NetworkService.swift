import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case unauthorized
    case serverError(String)
}

class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL = "http://localhost/mini-pos"
    
    private init() {}
    
    func request<T: Decodable>(endpoint: String, method: String = "GET", body: Data? = nil, requiresAuth: Bool = true) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth {
            if let token = AuthManager.shared.token {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                throw NetworkError.unauthorized
            }
        }
        
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError("Response không hợp lệ")
        }
        
        if httpResponse.statusCode == 401 {
            AuthManager.shared.logout()
            throw NetworkError.unauthorized
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError("Lỗi server: \(httpResponse.statusCode)")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("--- DECODING ERROR ---")
            print("URL: \(request.url?.absoluteString ?? "N/A")")
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw Response Data: \(responseString)")
            }
            print("Error: \(error)")
            print("----------------------")
            throw NetworkError.decodingError
        }
    }
}
