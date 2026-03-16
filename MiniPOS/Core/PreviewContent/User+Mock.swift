import Foundation

#if DEBUG
extension User {
    static let mockAdmin = User(id: 1, username: "admin", fullName: "Admin User", role: "Manager")
    static let mockStaff = User(id: 2, username: "staff1", fullName: "Nhân viên 1", role: "Staff")
}
#endif
