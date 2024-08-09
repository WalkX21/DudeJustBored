import Foundation
import Combine

class BalanceViewModel: ObservableObject {
    @Published var balances: [Balance] = []
    private var cancellables = Set<AnyCancellable>()
    
    func addBalance(amount: Double, currency: String) {
        let newBalance = Balance(currency: currency, amount: amount)
        balances.append(newBalance)
        
        // Here you would typically save the balance to your backend
        // For example:
        // databaseManager.saveBalances(balances: balances)
    }
    
    func updateBalance(id: UUID, amount: Double, currency: String) {
        if let index = balances.firstIndex(where: { $0.id == id }) {
            balances[index].amount = amount
            balances[index].currency = currency // Ensure currency is updated
        }
        
        // Save updated balances to backend
        // databaseManager.saveBalances(balances: balances)
    }
}
