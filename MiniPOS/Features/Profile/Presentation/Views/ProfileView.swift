import SwiftUI

struct ProfileView: View {
    @StateObject private var authManager = AuthManager.shared
    
    var body: some View {
        VStack(spacing: 30) {
                // Profile Header
                VStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    
                    VStack(spacing: 5) {
                        Text("Nhân viên")
                            .font(.headline)
                        
                        Text("ID: \(authManager.userId ?? 0)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 40)
                
                // Info Section
                VStack(spacing: 0) {
                    InfoRow(title: "Vai trò", value: "Nhân viên phục vụ", icon: "briefcase.fill")
                    Divider().padding(.leading, 50)
                    InfoRow(title: "Cửa hàng", value: "Mini POS Branch #1", icon: "mappin.and.ellipse")
                }
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.horizontal)
                
                Spacer()
                
                // Logout Button
                Button(action: {
                    authManager.logout()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Đăng xuất")
                    }
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1))
                    .foregroundColor(.red)
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("Thông tin")
        }
    
}

struct InfoRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
