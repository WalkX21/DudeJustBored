import Foundation

class DatabaseManager {
    private let usersFilePath: URL
    private let balancesFilePath: URL
    private let transactionsFilePath: URL
    
    init() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        usersFilePath = documentsDirectory.appendingPathComponent("users.csv")
        balancesFilePath = documentsDirectory.appendingPathComponent("balances.csv")
        transactionsFilePath = documentsDirectory.appendingPathComponent("transactions.csv")
    }
    
    // Load users from CSV
    func loadUsers() -> [User]? {
        guard let data = try? String(contentsOf: usersFilePath) else { return nil }
        let rows = data.split(separator: "\n")
        
        var users: [User] = []
        for row in rows {
            let columns = row.split(separator: ",")
            if columns.count == 4 {
                if let id = UUID(uuidString: String(columns[0])),
                   let name = String(columns[1]) as String?,
                   let email = String(columns[2]) as String?,
                   let password = String(columns[3]) as String? {
                    let user = User(id: id, name: name, email: email, password: password)
                    users.append(user)
                }
            }
        }
        return users
    }
    
    // Save users to CSV
    func saveUsers(users: [User]) {
        let csvString = users.map { "\($0.id),\($0.name),\($0.email),\($0.password)" }.joined(separator: "\n")
        try? csvString.write(to: usersFilePath, atomically: true, encoding: .utf8)
    }
    
    // Load balances for a specific user
    func loadBalances(forUserId userId: UUID) -> [Balance]? {
        guard let data = try? String(contentsOf: balancesFilePath) else { return nil }
        let rows = data.split(separator: "\n")
        
        var balances: [Balance] = []
        for row in rows {
            let columns = row.split(separator: ",")
            if columns.count == 3 {
                if let id = UUID(uuidString: String(columns[0])),
                   let amount = Double(columns[1]),
                   let currency = Currency(rawValue: String(columns[2])) {
                    let balance = Balance(id: id, amount: amount, currency: currency)
                    balances.append(balance)
                }
            }
        }
        return balances.filter { $0.currency == .mad } // Adjust based on userId if needed
    }
    
    // Save balances for a specific user
    func saveBalances(balances: [Balance], forUserId userId: UUID) {
        let csvString = balances.map { "\($0.id),\($0.amount),\($0.currency.rawValue)" }.joined(separator: "\n")
        try? csvString.write(to: balancesFilePath, atomically: true, encoding: .utf8)
    }
    
    // Load transactions for a specific user
    func loadTransactions(forUserId userId: UUID) -> [Transaction]? {
        guard let data = try? String(contentsOf: transactionsFilePath) else { return nil }
        let rows = data.split(separator: "\n")
        
        var transactions: [Transaction] = []
        for row in rows {
            let columns = row.split(separator: ",")
            if columns.count == 5 {
                if let id = UUID(uuidString: String(columns[0])),
                   let type = TransactionType(rawValue: String(columns[1])),
                   let amount = Double(columns[2]),
                   let date = DateFormatter().date(from: String(columns[3])),
                   let description = String(columns[4]) as String? {
                    let transaction = Transaction(id: id, type: type, amount: amount, date: date, description: description, category: "mad") // Adjust category if needed
                    transactions.append(transaction)
                }
            }
        }
        return transactions
    }
    
    // Save transactions for a specific user
    func saveTransactions(transactions: [Transaction], forUserId userId: UUID) {
        let csvString = transactions.map { "\($0.id),\($0.type.rawValue),\($0.amount),\(DateFormatter().string(from: $0.date)),\($0.description)" }.joined(separator: "\n")
        try? csvString.write(to: transactionsFilePath, atomically: true, encoding: .utf8)
    }
    
    // Get user by email and password
    func getUser(withEmail email: String, password: String) -> User? {
        guard let users = loadUsers() else { return nil }
        return users.first { $0.email == email && $0.password == password }
    }
}
