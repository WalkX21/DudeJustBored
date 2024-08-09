import Foundation
import CoreData
import Combine

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    private var cancellables = Set<AnyCancellable>()
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchTransactions()
    }

    func fetchTransactions() {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        do {
            transactions = try context.fetch(request)
        } catch {
            print("Failed to fetch transactions: \(error)")
        }
    }

    func addTransaction(amount: Double, date: Date, type: String, description: String, user: User) {
        let newTransaction = Transaction(context: context)
        newTransaction.amount = amount
        newTransaction.date = date
        newTransaction.type = type
        newTransaction.transactionDescription = description
        newTransaction.user = user

        saveContext()
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
