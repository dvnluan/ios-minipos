import Foundation

extension Double {
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        //formatter.numberStyle = .currency
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "\(Int(self))đ"
    }
}

