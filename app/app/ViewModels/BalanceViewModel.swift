import Foundation
import Combine

class BalanceViewModel: ObservableObject {
    @Published var balances: [Balance] = []

    // Initialize the balance with a specific currency
    func initializeBalance(currency: Currency, amount: Double) {
        let newBalance = Balance(id: UUID(), amount: amount, currency: currency)
        balances.append(newBalance)
    }
    
    // Update balance by adding an amount
    func addToBalance(amount: Double, currency: Currency) {
        if let index = balances.firstIndex(where: { $0.currency == currency }) {
            balances[index].amount += amount
        }
    }
    
    // Update balance by subtracting an amount
    func subtractFromBalance(amount: Double, currency: Currency) {
        if let index = balances.firstIndex(where: { $0.currency == currency }) {
            balances[index].amount -= amount
        }
    }
}
