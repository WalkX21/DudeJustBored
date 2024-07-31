import Foundation
import Combine

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    func saveTransaction(type: TransactionType, amount: Double, description: String, category: String) {
        let newTransaction = Transaction(
            id: UUID(),
            type: type,
            amount: amount,
            date: Date(),
            description: description,
            category: category // Ensure category is included
        )
        
        transactions.append(newTransaction)
    }
}
