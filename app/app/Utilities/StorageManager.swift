import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    func saveUser(_ user: User) {
        // Save user data
    }
    
    func getUser(forEmail email: String) -> User? {
        // Retrieve user data
        return nil
    }
    
    func saveBalance(_ balance: Balance) {
        // Save balance data
    }
    
    func getBalance() -> Balance? {
        // Retrieve balance data
        return nil
    }
    
    func saveTransaction(_ transaction: Transaction) {
        // Save transaction data
    }
    
    func getTransactions() -> [Transaction] {
        // Retrieve transactions
        return []
    }
}
