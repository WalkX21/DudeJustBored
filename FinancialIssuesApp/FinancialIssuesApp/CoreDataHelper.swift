import CoreData
import UIKit

class CoreDataHelper {
    static let shared = CoreDataHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchUser(username: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", username)
        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
    
    func saveUser(username: String, password: String) -> Bool {
        let user = User(context: context)
        user.username = username
        user.password = password
        do {
            try context.save()
            return true
        } catch {
            print("Error saving user: \(error)")
            return false
        }
    }
    
    func fetchBalances(for user: User) -> [Balance] {
        let request: NSFetchRequest<Balance> = Balance.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching balances: \(error)")
            return []
        }
    }
    
    func saveBalance(currency: String, amount: Double, type: String, for user: User) {
        let balance = Balance(context: context)
        balance.currency = currency
        balance.amount = amount
        balance.type = type
        do {
            try context.save()
        } catch {
            print("Error saving balance: \(error)")
        }
    }
    
    func fetchTransactions(for user: User) -> [Transaction] {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching transactions: \(error)")
            return []
        }
    }
    
    func saveTransaction(type: String, currency: String, amount: Double, descriptionn: String, for user: User) {
        let transaction = Transaction(context: context)
        transaction.type = type
        transaction.currency = currency
        transaction.amount = amount
        transaction.descriptionn = descriptionn
        transaction.date = Date()

        do {
            try context.save()
        } catch {
            print("Error saving transaction: \(error)")
        }
    }
}
