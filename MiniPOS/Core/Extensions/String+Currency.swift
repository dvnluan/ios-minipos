import Foundation

extension String {
    func toCurrency() -> String {
        let value = Double(self) ?? 0
        return value.toCurrency()
    }
}
