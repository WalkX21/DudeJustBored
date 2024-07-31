import Foundation
import Combine

class AppViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoggedIn: Bool = false
    @Published var userBalances: [Balance] = [] // Balances specific to the logged-in user
    @Published var userTransactions: [Transaction] = [] // Transactions specific to the logged-in user
    @Published var errorMessage: String = ""

    private let databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
        loadUsers()
        loadUserData()
    }

    // Load users from the database
    func loadUsers() {
        if let users = databaseManager.loadUsers() {
            // Handle loaded users if necessary
        }
    }

    // Save users to the database
    func saveUsers() {
        if let user = self.user {
            databaseManager.saveUsers(users: [user]) // Save the current user
        }
    }

    // Load user data (balances and transactions) for the logged-in user
    func loadUserData() {
        guard let userId = user?.id else { return }
        
        if let balances = databaseManager.loadBalances(forUserId: userId) {
            userBalances = balances
        }

        if let transactions = databaseManager.loadTransactions(forUserId: userId) {
            userTransactions = transactions
        }
    }

    // Save user data (balances and transactions) for the logged-in user
    func saveUserData() {
        guard let userId = user?.id else { return }
        
        databaseManager.saveBalances(balances: userBalances, forUserId: userId)
        databaseManager.saveTransactions(transactions: userTransactions, forUserId: userId)
    }

    func login(email: String, password: String) {
        if let user = databaseManager.getUser(withEmail: email, password: password) {
            isLoggedIn = true
            self.user = user
            loadUserData() // Load user-specific data
        } else {
            errorMessage = "Invalid email or password."
        }
    }

    func signUp(name: String, email: String, password: String) {
        let newUser = User(id: UUID(), name: name, email: email, password: password) // Mock user
        databaseManager.saveUsers(users: [newUser]) // Save the new user
        isLoggedIn = true
        user = newUser
        saveUserData() // Initialize user data
    }

    func addOrUpdateBalance(amount: Double, currency: Currency) {
        if let index = userBalances.firstIndex(where: { $0.currency == currency }) {
            userBalances[index].amount = amount // Update existing balance
        } else {
            let newBalance = Balance(id: UUID(), amount: amount, currency: currency)
            userBalances.append(newBalance) // Add new balance if it doesn't exist
        }
        saveUserData() // Save balances after adding/updating
    }

    func addTransaction(type: TransactionType, amount: Double, description: String, category: String) {
        let newTransaction = Transaction(id: UUID(), type: type, amount: amount, date: Date(), description: description, category: category)
        userTransactions.append(newTransaction)

        // Update balance based on transaction type
        if type == .income {
            if let index = userBalances.firstIndex(where: { $0.currency == .mad }) {
                let currentBalance = userBalances[index].amount
                let newBalance = currentBalance + amount
                userBalances[index].amount = newBalance // Update balance for income
            }
        } else {
            if let index = userBalances.firstIndex(where: { $0.currency == .mad }) {
                let currentBalance = userBalances[index].amount
                let newBalance = currentBalance - amount
                userBalances[index].amount = newBalance // Update balance for expense
            }
        }

        saveUserData() // Save transactions after adding
    }
}
